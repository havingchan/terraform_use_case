provider "aws" {
  region = "us-west-2"
}

module "subnet_web1" {
  source      = "../../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.0.0/24"
  az          = "us-west-2a"
  subnet_name = "Subnet-Web1"
}

module "subnet_web2" {
  source      = "../../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.3.0/24"
  az          = "us-west-2b"
  subnet_name = "Subnet-Web2"
}

module "subnet_app1" {
  source      = "../../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.1.0/24"
  az          = "us-west-2a"
  subnet_name = "Subnet-APP1"
}

module "subnet_app2" {
  source      = "../../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.4.0/24"
  az          = "us-west-2b"
  subnet_name = "Subnet-APP2"
}

module "subnet_db1" {
  source      = "../../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.2.0/24"
  az          = "us-west-2a"
  subnet_name = "Subnet-DB1"
}

module "subnet_db2" {
  source      = "../../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.5.0/24"
  az          = "us-west-2b"
  subnet_name = "Subnet-DB2"
}