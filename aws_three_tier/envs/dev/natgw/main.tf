provider "aws" {
  region = "us-west-2"
}

module "natgw1" {
  source   = "../../../modules/natgw"
  vpc_name = "Having-Web-App-VPC"
  subnet_name = "Subnet-APP1"
  natgw_name = "Having-Web-App-NATGW1"
  rt_name = "RTB-APP1"
}

module "natgw2" {
  source   = "../../../modules/natgw"
  vpc_name = "Having-Web-App-VPC"
  subnet_name = "Subnet-APP2"
  natgw_name = "Having-Web-App-NATGW2"
  rt_name = "RTB-APP2"
}