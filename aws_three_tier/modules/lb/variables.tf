variable "vpc_name" {
  description = "The name of the VPC"
  type        = string

}

variable "subnet_app1_name" {
  description = "The name of the subnet"
  type        = string
  
}

variable "subnet_app2_name" {
  description = "The name of the subnet"
  type        = string
  
}

variable "sg_name" {
  description = "The name of the subnet"
  type        = string
}

variable "ami_app_name" {
  description = "The name of the route table"
  type        = string
  default     = "AppTierImage"
}

variable "ami_web_name" {
  description = "The name of the route table"
  type        = string
  default     = "WebTierImage"
}

variable "lb_target_group" {
  type = string
}


variable "lb_target_group_name" {
  description = "The name of the target group"
  type        = string

}

variable "lb_target_group_port" {
  description = "The port of the target group"
  type        = number

}

variable "lb_target_group_protocol" {
  description = "The protocol of the target group"
  type        = string
  default     = "HTTP"

}

variable "lb_target_group_target_type" {
  description = "The target type of the target group"
  type        = string
  default     = "instance"

}

variable "lb_target_group_health_check_path" {
  description = "The path of the health check"
  type        = string

}

variable "lb_target_group_health_check_protocol" {
  description = "The protocol of the health check"
  type        = string
  default     = "HTTP"

}

variable "lb_target_group_health_check_port" {
  description = "The port of the health check"
  type        = number

}

variable "lb_target_group_health_check_interval" {
  description = "The interval of the health check"
  type        = number
  default     = 30

}

variable "lb_target_group_health_check_timeout" {
  description = "The timeout of the health check"
  type        = number
  default     = 5

}

variable "lb_target_group_health_check_healthy_threshold" {
  description = "The healthy threshold of the health check"
  type        = number
  default     = 2

}

variable "lb_target_group_health_check_unhealthy_threshold" {
  description = "The unhealthy threshold of the health check"
  type        = number
  default     = 2

}

variable "lb" {
  type = string
}

variable "lb_name" {
  description = "The name of the internal load balancer"
  type        = string

}

variable "lb_type" {
  description = "The type of the internal load balancer"
  type        = string
  default     = "application"

}

variable "internal_bool" {
  description = "The boolean value of the internal load balancer"
  type        = bool
  default     = true
  
}

variable "lb_listener" {
  type = string
}

variable "lb_listener_port" {
  description = "The port of the internal load balancer listener"
  type        = number

}

variable "lb_listener_protocol" {
  description = "The protocol of the internal load balancer listener"
  type        = string
  default     = "HTTP"

}

variable "lb_listener_default_action_type" {
  description = "The type of the internal load balancer listener default action"
  type        = string
  default     = "forward"

}

