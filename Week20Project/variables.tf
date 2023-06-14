#Specifies the region for the infrastructure 
variable "aws_region" {
  description = "Region where the environment will be"
  type        = string
  default     = "us-east-1"
}

#Specifies the active default VPC
variable "vpc_id" {
  description = "dp_default_vpc"
  type        = string
  default     = "vpc-062a5bec3afac3b7d"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

#Defines private subnet
variable "private_subnets" {
  default = {
    "private_subnet_1" = 1
  }
}

#Defines public subnet
variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
  }
}


#Defines a variable subnet in us-east-1a
variable "variables_sub_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "10.0.202.0/24"
}

variable "variables_sub_az" {
  description = "Availability Zone used for Variables Subnet"
  type        = string
  default     = "us-east-1a"
}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assigment for Variables Subnet"
  type        = bool
  default     = true
}