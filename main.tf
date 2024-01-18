data "aws_iam_policy" "ssm_full_access" {
  name = "AmazonSSMFullAccess"
}

data "aws_iam_policy" "cloudwatch_full_access" {
  name = "CloudWatchFullAccessV2"
}

resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
    tags = merge(tomap({
     "Name" = var.role_name,
     "CreateBy" = "Terraform"
   }), var.tags)
}

resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = data.aws_iam_policy.ssm_full_access.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_full_access" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = data.aws_iam_policy.cloudwatch_full_access.arn
}