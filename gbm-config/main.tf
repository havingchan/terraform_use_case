provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "webserver-gbm" {
  source          = "../modules/webserver"
  vpc_id          = aws_vpc.main.id
  cidr_block      = "10.0.0.0/16"
  ami             = "ami-0c7c4e3c6b4941f0f"
  instance_type   = "t3.micro"
  webserver_name  = "GBM's"
  department_name = "GBM"
  project_name    = "Equity"
}
