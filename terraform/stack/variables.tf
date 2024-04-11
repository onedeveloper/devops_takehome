variable "project_name" {
  type    = string
  default = "vention"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "environment" {
  type    = string
  default = "ERROR"
}

variable "tags" {
  type = map(any)
  default = {
    Terraform   = ""
    Environment = ""
  }
}