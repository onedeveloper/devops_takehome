variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the Subnet"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone where the subnet is to be created"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether the instances that are launched in this subnet should be assigned a public IP address"
  type        = bool
}
