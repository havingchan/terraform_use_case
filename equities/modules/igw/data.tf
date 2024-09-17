data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnet" "subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.subnet_name_1}"]
  }
}

data "aws_subnet" "subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.subnet_name_2}"]
  }
}