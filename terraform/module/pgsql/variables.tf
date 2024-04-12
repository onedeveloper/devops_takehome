variable "project_name" {
  type    = string
  default = "vention"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tags" {
  type = map(any)
  default = {
    Terraform   = ""
    Environment = ""
  }
}