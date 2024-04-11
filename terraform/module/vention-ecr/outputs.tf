output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.this.name
}

output "repository_id" {
  value = aws_ecr_repository.this.registry_id
}

output "repository_arn" {
  value = aws_ecr_repository.this.arn
}

output "repository_uri" {
  value = aws_ecr_repository.this.repository_url
}

output "repository_image_tag_mutability" {
  value = aws_ecr_repository.this.image_tag_mutability
}
