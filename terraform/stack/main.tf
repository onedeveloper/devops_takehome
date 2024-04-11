module "vpc" {
  source = "../module/vpc"

  project_name = var.project_name
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  tags = var.tags
}