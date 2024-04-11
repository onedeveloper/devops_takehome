module "vention-ecr" {
    source          = "../module/vention-ecr"
    aws_region      = "us-east-1"
    repository_name = "vention"
}






output "ecr_repository_url" {
  value = module.vention-ecr.repository_url
}

module "ecs_example_fargate" {
  source  = "terraform-aws-modules/ecs/aws//examples/fargate"
  version = "5.11.1"
}