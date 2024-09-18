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