data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnet" "subnet1" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.subnet1_name}"]
  }
}

data "aws_subnet" "subnet2" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.subnet2_name}"]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]

  }

  filter {
    name   = "tag:Name"
    values = ["${var.sg_name}"]
  }

}

data "aws_ami" "ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }

}

data "aws_lb_target_group" "lbtg" {
  name = var.lbtg_name
}

# data "aws_key_pair" "key_pair" {
#   key_name = var.key_name
# }