module "app_tier_asg" {
  source                    = "../../../modules/asg"
  vpc_name                  = "Having-Web-App-VPC"
  subnet1_name              = "Subnet-APP1"
  subnet2_name              = "Subnet-APP2"
  sg_name                   = "App-Instance-SG"
  ami_name                  = "AppTierImage"
  template_name             = "app_tier_template"
  instance_type             = "t3.micro"
  # key_name                  = "havingwebappkey"
  iam_instance_profile_name = "havingwebappec2role"
  asg_name                  = "App-Tier-ASG"
  lbtg_name                 = "App-Tier-Target-Group"
  asg_min_size              = 1
  asg_max_size              = 2
  asg_desired_capacity      = 1
}

module "web_tier_asg" {
  source                    = "../../../modules/asg"
  vpc_name                  = "Having-Web-App-VPC"
  subnet1_name              = "Subnet-Web1"
  subnet2_name              = "Subnet-Web2"
  sg_name                   = "Web-Instance-SG"
  ami_name                  = "WebTierImage"
  template_name             = "web_tier_template"
  instance_type             = "t3.micro"
  # key_name                  = "having"
  iam_instance_profile_name = "havingwebappec2role"
  asg_name                  = "Web-Tier-ASG"
  lbtg_name                 = "Web-Tier-Target-Group"
  asg_min_size              = 1
  asg_max_size              = 2
  asg_desired_capacity      = 1
}