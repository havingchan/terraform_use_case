data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnet" "subnet_app1" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.subnet_app1_name}"]
  }
}

data "aws_subnet" "subnet_app2" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.subnet_app2_name}"]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = ["${var.sg_name}"]
  }

}

data "aws_ami" "ami_app" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.ami_app_name}"]
  }

}

data "aws_ami" "ami_web" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.ami_web_name}"]
  }

}