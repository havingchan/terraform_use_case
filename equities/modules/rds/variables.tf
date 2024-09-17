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

variable "dbsg" {
  description = "The name of the subnet"
  type        = string

}

variable "dbsg_name" {
  description = "The name of the subnet"
  type        = string

}

variable "cluster_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "engine_mode" {
  type = string
}

variable "az1" {
  type = string
}

variable "az2" {
  type = string
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type = string
}


variable "sg_name" {
  description = "The name of the subnet"
  type        = string
}

variable "instance_class" {
  type = string
}

variable "identifier1" {
  type = string
}

variable "identifier2" {
  type = string
}
