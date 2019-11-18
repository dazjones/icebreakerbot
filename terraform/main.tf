terraform {
  backend "s3" {}
}

module "iam_system_user" {
  source  = "cloudposse/iam-system-user/aws"
  version = "0.6.0"
  name    = "icebreakerbot"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["cloudformation:*"]
    resources = ["*"]
    effect = "Allow"
  }
  statement {
    actions = ["lambda:*"]
    resources = ["*"]
    effect = "Allow"
  }
  statement {
    actions = ["s3:*"]
    resources = ["*"]
    effect = "Allow"
  }
  statement {
    actions = ["iam:GetRole"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["iam:AttachRolePolicy"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["iam:PassRole"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["events:*"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["apigateway:*"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["iam:PutRolePolicy"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["ssm:PutParameter"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["ssm:GetParameter"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["logs:DescribeLogGroups"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["logs:CreateLogGroup"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["logs:DeleteLogGroup"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["iam:CreateRole"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["sns:*"]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = ["dynamodb:*"]
    effect = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "default" {
  name   = module.iam_system_user.user_name
  user   = module.iam_system_user.user_name
  policy = data.aws_iam_policy_document.default.json
}
