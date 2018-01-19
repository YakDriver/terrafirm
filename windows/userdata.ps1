<powershell>

# log of the userdata install
Start-Transcript -path C:\Temp\watchmaker_userdata_install.log -append

# close the firewall
netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=deny

# Set Administrator password
$admin = [adsi]("WinNT://./administrator, user")
$admin.psbase.invoke("SetPassword", "THIS_IS_NOT_THE_PASSWORD")
$admin.psbase.CommitChanges()

#wm should go here

# Set Administrator password
$admin = [adsi]("WinNT://./xadministrator, user")
$admin.psbase.invoke("SetPassword", "THIS_IS_NOT_THE_PASSWORD")
$admin.psbase.CommitChanges()

# open firewall for winrm
netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow

# fix the lgpos to allow winrm
C:\salt\salt-call --local -c C:\Watchmaker\salt\conf lgpo.set_reg_value `
    key='HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\AllowBasic' `
    value='1' `
    vtype='REG_DWORD'
    
C:\salt\salt-call --local -c C:\Watchmaker\salt\conf lgpo.set_reg_value `
    key='HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\AllowUnencryptedTraffic' `
    value='1' `
    vtype='REG_DWORD'

# this will become the watchmaker portion of install
WATCHMAKER_INSTALL_GOES_HERE

Stop-Transcript

# script will setup winrm and set the timeout
</powershell>
<script>
winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1900000"} 
</script>
