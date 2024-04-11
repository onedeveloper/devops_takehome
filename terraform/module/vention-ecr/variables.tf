variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
  default     = "vention"
}