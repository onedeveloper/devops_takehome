data "aws_iam_policy_document" "restrict_iam_and_billing_policy_document" {
  statement {
    effect = "Deny"

    actions = [
      # Block IAM related actions
      "iam:*",
      # Block actions to view billing data
      "aws-portal:*Billing"
    ]

    resources = ["*"] # Apply the deny to all resources
  }
}

# Create IAM users
resource "aws_iam_user" "restricted_members" {
  count = length("${var.members}")

  name = var.members[count.index].username
}

# Attach read-only policy to IAM users
resource "aws_iam_user_policy_attachment" "read_only_policy" {
  count = length("${var.members}")

  user       = aws_iam_user.restricted_members[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Exclude IAM and billing policies from read-only access
resource "aws_iam_policy" "exclude_policy" {
  name        = "ExcludeIAMAndBilling"
  description = "Policy that excludes IAM and billing actions"
  policy      = data.aws_iam_policy_document.restrict_iam_and_billing.json
}


resource "aws_iam_policy" "restricted_user_policy" {
  name        = "restricted-iam-billing-policy"
  description = "Policy to restrict IAM and billing access for a user"
  policy      = data.aws_iam_policy_document.restrict_iam_and_billing.json
}

resource "aws_iam_user_policy_attachment" "exclude_policies" {
  count = length("${var.members}")

  user       = aws_iam_user.restricted_members[count.index].name
  policy_arn = aws_iam_policy.exclude_policy.arn
}

