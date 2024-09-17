variable "vpc_name" {
  description = "The name of the VPC"
  type        = string

}

variable "subnet_name" {
  type = string
}

variable "natgw_name" {
  description = "The name of the subnet"
  type        = string
}

variable "rt_name" {
  description = "The name of the route table"
  type        = string
  
}