module "vpc" {
  source         = "../../../modules/vpc"
  vpc_name       = "Having-Web-App-VPC"
  vpc_cidr_block = "10.0.0.0/16"
}
