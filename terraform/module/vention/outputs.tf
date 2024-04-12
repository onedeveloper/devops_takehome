# Output IAM user names
output "iam_user_names" {
  value = aws_iam_user.restricted_members[*].name
}