variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "cidr_block" {
  type        = string
  description = "CIDR Block"
}

variable "ami" {
  type        = string
  description = "AMI for the webserver instance"
}

variable "instance_type" {
  type        = string
  default        = "t3.micro"
  description = "Instance type for the webserver instance"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Instance count for the webserver instance"
}

variable "webserver_name" {
  type        = string
  description = "Name of the webserver instance"
}

variable "department_name" {
  type        = string
  description = "Name of the department"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}
