variable "environment" {
  description = "Environment name"
}

variable "app_name" {
  description = "Application name"
}

variable "aws_account_ids" {
  description = "List of AWS account IDs that should have access to the repository"
  type        = list(string)
}
