provider "aws" {
  region = "us-west-2"
}

module "igw" {
  source   = "../../../modules/igw"
  vpc_name = "Having-Web-App-VPC"
  subnet_name_1 = "Subnet-Web1"
  subnet_name_2 = "Subnet-Web2"
  igw_name = "Having-Web-App-IGW"
  rt_name = "RTB-WEB"
}