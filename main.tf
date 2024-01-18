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

  inline_policy {
    name = "AmazonSSMFullAccess"
    policy = file("${path.module}/files/ssm_full_access.json")
  }
    inline_policy {
    name = "CloudWatchFullAccessV2"
    policy = file("${path.module}/files/cloudwatch_full_access_v2.json")
  }
    tags = merge(tomap({
     "Name" = var.role_name,
     "CreateBy" = "Terraform"
   }), var.tags)
}