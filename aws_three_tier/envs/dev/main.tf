provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source         = "../../modules/vpc"
  vpc_name       = "Having-Web-App-VPC"
  vpc_cidr_block = "10.0.0.0/16"
}

module "sg" {
  source = "./sg"
}

module "subnet_web1" {
  source      = "../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.0.0/24"
  az          = "us-west-2a"
  subnet_name = "Subnet-Web1"
}

module "subnet_web2" {
  source      = "../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.3.0/24"
  az          = "us-west-2b"
  subnet_name = "Subnet-Web2"
}

module "subnet_app1" {
  source      = "../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.1.0/24"
  az          = "us-west-2a"
  subnet_name = "Subnet-APP1"
}

module "subnet_app2" {
  source      = "../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.4.0/24"
  az          = "us-west-2b"
  subnet_name = "Subnet-APP2"
}

module "subnet_db1" {
  source      = "../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.2.0/24"
  az          = "us-west-2a"
  subnet_name = "Subnet-DB1"
}

module "subnet_db2" {
  source      = "../../modules/subnet"
  vpc_name    = "Having-Web-App-VPC"
  cidr_block  = "10.0.5.0/24"
  az          = "us-west-2b"
  subnet_name = "Subnet-DB2"
}


module "rds" {
  source             = "../../modules/rds"
  vpc_name           = "Having-Web-App-VPC"
  subnet1_name       = "Subnet-DB1"
  subnet2_name       = "Subnet-DB2"
  dbsg               = "havingwebappdbsg"
  dbsg_name          = "Having-Web-App-DBSG"
  cluster_identifier = "havingwebappauroracluster"
  engine             = "aurora-mysql"
  engine_version     = "8.0.mysql_aurora.3.05.2"
  engine_mode        = "provisioned"
  az1                = "us-west-2a"
  az2                = "us-west-2b"
  database_name      = "havingwebappdb"
  master_username    = "admin"
  master_password    = "admin123"
  sg_name            = "DB-Instance-SG"
  instance_class     = "db.r6g.large"
  identifier1        = "havingwebappaurorainstance1"
  identifier2        = "havingwebappaurorainstance2"
}

module "igw" {
  source        = "../../modules/igw"
  vpc_name      = "Having-Web-App-VPC"
  subnet_name_1 = "Subnet-Web1"
  subnet_name_2 = "Subnet-Web2"
  igw_name      = "Having-Web-App-IGW"
  rt_name       = "RTB-WEB"
}

module "natgw1" {
  source      = "../../modules/natgw"
  vpc_name    = "Having-Web-App-VPC"
  subnet_name = "Subnet-APP1"
  natgw_name  = "Having-Web-App-NATGW1"
  rt_name     = "RTB-APP1"
}

module "natgw2" {
  source      = "../../modules/natgw"
  vpc_name    = "Having-Web-App-VPC"
  subnet_name = "Subnet-APP2"
  natgw_name  = "Having-Web-App-NATGW2"
  rt_name     = "RTB-APP2"
}

module "app_tier_internal_lb" {
  source                                = "../../modules/lb"
  vpc_name                              = "Having-Web-App-VPC"
  lb_target_group                       = "app_tier_target_group"
  lb_target_group_name                  = "App-Tier-Target-Group"
  lb_target_group_port                  = 4000
  lb_target_group_protocol              = "HTTP"
  lb_target_group_target_type           = "instance"
  lb_target_group_health_check_path     = "/health"
  lb_target_group_health_check_protocol = "HTTP"
  lb_target_group_health_check_port     = 4000
  lb_target_group_health_check_interval = 30
  lb_target_group_health_check_timeout  = 5
  lb                                    = "app_tier_internal_lb"
  lb_name                               = "App-Tier-Internal-LB"
  lb_type                               = "application"
  internal_bool                         = "true"
  sg_name                               = "Internal-LB-SG"
  subnet_app1_name                      = "Subnet-APP1"
  subnet_app2_name                      = "Subnet-APP2"
  lb_listener                           = "app_tier_internal_lb_listener"
  lb_listener_port                      = 80
  lb_listener_protocol                  = "HTTP"
  lb_listener_default_action_type       = "forward"

}

module "web_tier_external_lb" {
  source                                = "../../modules/lb"
  vpc_name                              = "Having-Web-App-VPC"
  lb_target_group                       = "web_tier_target_group"
  lb_target_group_name                  = "Web-Tier-Target-Group"
  lb_target_group_port                  = 80
  lb_target_group_protocol              = "HTTP"
  lb_target_group_target_type           = "instance"
  lb_target_group_health_check_path     = "/health"
  lb_target_group_health_check_protocol = "HTTP"
  lb_target_group_health_check_port     = 80
  lb_target_group_health_check_interval = 30
  lb_target_group_health_check_timeout  = 5
  lb                                    = "web_tier_external_lb"
  lb_name                               = "Web-Tier-external-LB"
  lb_type                               = "application"
  internal_bool                         = "false"
  sg_name                               = "Internet-Facing-LB-SG"
  subnet_app1_name                      = "Subnet-Web1"
  subnet_app2_name                      = "Subnet-Web2"
  lb_listener                           = "web_tier_external_lb_listener"
  lb_listener_port                      = 80
  lb_listener_protocol                  = "HTTP"
  lb_listener_default_action_type       = "forward"

}

module "app_tier_asg" {
  source        = "../../modules/asg"
  vpc_name      = "Having-Web-App-VPC"
  subnet1_name  = "Subnet-APP1"
  subnet2_name  = "Subnet-APP2"
  sg_name       = "App-Instance-SG"
  ami_name      = "AppTierImage"
  template_name = "app_tier_template"
  instance_type = "t3.micro"
  # key_name                  = "havingwebappkey"
  iam_instance_profile_name = "havingwebappec2role"
  asg_name                  = "App-Tier-ASG"
  lbtg_name                 = "App-Tier-Target-Group"
  asg_min_size              = 1
  asg_max_size              = 2
  asg_desired_capacity      = 1
}

module "web_tier_asg" {
  source        = "../../modules/asg"
  vpc_name      = "Having-Web-App-VPC"
  subnet1_name  = "Subnet-Web1"
  subnet2_name  = "Subnet-Web2"
  sg_name       = "Web-Instance-SG"
  ami_name      = "WebTierImage"
  template_name = "web_tier_template"
  instance_type = "t3.micro"
  # key_name                  = "having"
  iam_instance_profile_name = "havingwebappec2role"
  asg_name                  = "Web-Tier-ASG"
  lbtg_name                 = "Web-Tier-Target-Group"
  asg_min_size              = 1
  asg_max_size              = 2
  asg_desired_capacity      = 1
}
