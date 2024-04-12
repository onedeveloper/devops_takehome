variable "members" {
  description = "A list of users in the group"
  type        = list(string)
  default     = []
}

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