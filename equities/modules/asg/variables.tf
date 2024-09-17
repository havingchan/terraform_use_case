variable "vpc_name" {
  description = "The name of the VPC"
  type        = string

}

variable "subnet1_name" {
  description = "The name of the subnet"
  type        = string

}

variable "subnet2_name" {
  description = "The name of the subnet"
  type        = string

}

variable "sg_name" {
  description = "The name of the subnet"
  type        = string
}

variable "ami_name" {
  description = "The name of the route table"
  type        = string
  default     = "AppTierImage"
}

variable "template_name" {
  description = "The name of the template"
  type        = string
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t2.micro"

}

# variable "key_name" {
#   description = "The name of the key pair"
#   type        = string

# }

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile"
  type        = string

}

variable "asg_name" {
  description = "The name of the auto scaling group"
  type        = string

}

variable "asg_min_size" {
  description = "The minimum size of the auto scaling group"
  type        = number
  default     = 1

}

variable "asg_max_size" {
  description = "The maximum size of the auto scaling group"
  type        = number
  default     = 2

}

variable "asg_desired_capacity" {
  description = "The desired capacity of the auto scaling group"
  type        = number
  default     = 2

}

variable "lbtg_name" {
  type = string

}