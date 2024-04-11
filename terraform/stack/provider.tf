terraform {
  required_version = ">= 1.7.5" # Specify the minimum required Terraform version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region = "us-east-1" # Choose your AWS region
}
