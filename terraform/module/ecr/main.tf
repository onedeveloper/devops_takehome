data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "main" {
  name = "${var.project_name}-${var.environment}"

      image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = false
    }
  

  tags = merge(
    {
      Name = "${var.project_name}-${var.environment}"
    },
    var.tags
  )
}



data "aws_iam_policy_document" "vention-ecr-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_ecr_repository_policy" "example" {
  repository = aws_ecr_repository.main.name
  policy     = data.aws_iam_policy_document.vention-ecr-policy.json
}