data "aws_iam_policy" "ssm_full_access" {
  name = "AmazonSSMFullAccess"
}

data "aws_iam_policy" "cloudwatch_full_access" {
  name = "CloudWatchFullAccessV2"
}

resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = var.ec2_role_name
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
     "Name" = var.ec2_role_name,
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

resource "aws_iam_instance_profile" "ec2_cloudwatch_role_profile" {
  name = var.ec2_role_name
  role = aws_iam_role.ec2_cloudwatch_role.name
}

resource "aws_ssm_parameter" "cloudwatch_agent" {
  name        = "/alarm/AWS-CWAgentLinuxConfig"
  description = "EC2 CWAgent configuration"
  type        = "String"
  value       = file("${path.module}/files/ec2-cw-agent-config.json")
  tier = "Standard"
  tags = merge(tomap({
     "Name" = "AWS-CWAgentLinuxConfig",
     "CreateBy" = "Terraform"
   }), var.tags)
}