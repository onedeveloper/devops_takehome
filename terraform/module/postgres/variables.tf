variable "vpc_id" {
    description = "ID of the VPC"
    type        = string
}

variable "subnet_ids" {
    description = "List of subnet IDs"
    type        = list(string)
}

variable "engine_version" {
    description = "Version of the database engine"
    type        = string
}

variable "instance_class" {
    description = "Instance class for the database"
    type        = string
}

variable "allocated_storage" {
    description = "Allocated storage for the database"
    type        = number
}

variable "vpc_cidr_block" {
    description = "CIDR block of the VPC"
    type        = string
}