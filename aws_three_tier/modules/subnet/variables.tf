variable "vpc_name" {
    description = "The name of the VPC"
    type        = string

}

variable "subnet_name" {
    description = "The name of the subnet"
    type        = string
}

variable "cidr_block" {
    description = "The CIDR block for the subnet"
    type        = string
}

variable "az" {
    description = "The availability zone in which to create the subnet"
    type        = string
}