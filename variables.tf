variable "role_name" {
    type = string
    default = "EC2-CloudWatch-Role"
    description = "EC2 CloudWatch Role name"
}
variable "tags" {
  type = map(string)
  description = "Tags"
  default = {
    "Name" = "EC2-CloudWatch-Role",
    "CreateBy" = "Terraform"
  }
}