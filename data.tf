# Template for initial configuration bash script
data "template_file" "win_userdata" {
  template = "${file("windows/userdata.ps1")}"

  vars {
    tfi_git_repo         = "${var.tfi_git_repo}"
    tfi_git_ref          = "${var.tfi_git_ref}"
    tfi_common_args      = "${var.tfi_common_args}"
    tfi_win_args         = "${var.tfi_win_args}"
    tfi_rm_pass          = "${var.tfi_rm_pass}"
    tfi_rm_user          = "${var.tfi_rm_user}"
    tfi_win_userdata_log = "${var.tfi_win_userdata_log}"
    tfi_s3_bucket        = "${var.tfi_s3_bucket}"
    tfi_build_date       = "${var.tfi_build_date}"
    tfi_build_id         = "${var.tfi_build_id}"
  }
}

# Template for initial configuration bash script
data "template_file" "lx_userdata" {
  template = "${file("linux/userdata.sh")}"

  vars {
    tfi_git_repo        = "${var.tfi_git_repo}"
    tfi_git_ref         = "${var.tfi_git_ref}"
    tfi_common_args     = "${var.tfi_common_args}"
    tfi_lx_args         = "${var.tfi_lx_args}"
    tfi_ssh_user        = "${var.tfi_ssh_user}"
    tfi_lx_userdata_log = "${var.tfi_lx_userdata_log}"
    tfi_s3_bucket       = "${var.tfi_s3_bucket}"
    tfi_build_date      = "${var.tfi_build_date}"
    tfi_build_id        = "${var.tfi_build_id}"
  }
}

#used just to find the ami id matching criteria, which is then used in provisioning resource
data "aws_ami" "centos6" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 0)}"]
  }

  owners = "${var.tfi_linux_ami_owners}"
}

#used just to find the ami id matching criteria, which is then used in provisioning resource
data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 1)}"]
  }

  owners = "${var.tfi_linux_ami_owners}"
}

#used just to find the ami id matching criteria, which is then used in provisioning resource
data "aws_ami" "rhel6" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 2)}"]
  }

  owners = "${var.tfi_linux_ami_owners}"
}

#used just to find the ami id matching criteria, which is then used in provisioning resource
data "aws_ami" "rhel7" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 3)}"]
  }

  owners = "${var.tfi_linux_ami_owners}"
}

#used just to find the ami id matching criteria, which is then used in provisioning resource
data "aws_ami" "windows2008" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 4)}"]
  }

  owners = "${var.tfi_windows_ami_owners}"
}

#used just to find the ami id matching criteria, which is then used in provisioning resource
data "aws_ami" "windows2012" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 5)}"]
  }

  owners = "${var.tfi_windows_ami_owners}"
}

#used just to find the ami id matching criteria, which is then used in provisioning resource
data "aws_ami" "windows2016" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 6)}"]
  }

  owners = "${var.tfi_windows_ami_owners}"
}

data "aws_ami" "win16sql16s" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 7)}"]
  }

  owners = "${var.tfi_windows_ami_owners}"
}

data "aws_ami" "win16sql16e" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 8)}"]
  }

  owners = "${var.tfi_windows_ami_owners}"
}

data "aws_ami" "win16sql17s" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 9)}"]
  }

  owners = "${var.tfi_windows_ami_owners}"
}

data "aws_ami" "win16sql17e" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["${var.tfi_other_filters["virtualization_type"]}"]
  }

  filter {
    name   = "name"
    values = ["${element(var.tfi_ami_name_filters, 10)}"]
  }

  owners = "${var.tfi_windows_ami_owners}"
}

# data source (place to put the ami id strings), used to mitigate lack of intermediate variables and interpolation
data "null_data_source" "spel_instance_amis" {
  inputs = {
    "centos6" = "${data.aws_ami.centos6.id}"
    "centos7" = "${data.aws_ami.centos7.id}"
    "rhel6"   = "${data.aws_ami.rhel6.id}"
    "rhel7"   = "${data.aws_ami.rhel7.id}"
  }
}

# data source (place to put the ami id strings), used to mitigate lack of intermediate variables and interpolation
data "null_data_source" "windows_instance_amis" {
  inputs = {
    "win08"       = "${data.aws_ami.windows2008.id}"
    "win12"       = "${data.aws_ami.windows2012.id}"
    "win16"       = "${data.aws_ami.windows2016.id}"
    "win16sql16s" = "${data.aws_ami.win16sql16s.id}"
    "win16sql16e" = "${data.aws_ami.win16sql16e.id}"
    "win16sql17s" = "${data.aws_ami.win16sql17s.id}"
    "win16sql17e" = "${data.aws_ami.win16sql17e.id}"
  }
}
