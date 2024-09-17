module "app_tier_internal_lb" {
  source                                = "../../../modules/lb"
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
  sg_name = "Internal-LB-SG"
  subnet_app1_name = "Subnet-APP1"
  subnet_app2_name = "Subnet-APP2"
  lb_listener                           = "app_tier_internal_lb_listener"
  lb_listener_port                      = 80
  lb_listener_protocol                  = "HTTP"
  lb_listener_default_action_type       = "forward"

}

module "web_tier_external_lb" {
  source                                = "../../../modules/lb"
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
  sg_name = "Internet-Facing-LB-SG"
  subnet_app1_name = "Subnet-Web1"
  subnet_app2_name = "Subnet-Web2"
  lb_listener                           = "web_tier_external_lb_listener"
  lb_listener_port                      = 80
  lb_listener_protocol                  = "HTTP"
  lb_listener_default_action_type       = "forward"

}