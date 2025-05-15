output "db_instance_endpoint" {
  description = "The database connection endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_address" {
  description = "The database connection address"
  value       = aws_db_instance.main.address
}

output "db_instance_port" {
  description = "The database connection port"
  value       = aws_db_instance.main.port
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.main.db_name
}

output "db_credentials_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret storing database credentials"
  value       = aws_secretsmanager_secret.db_credentials.arn
}
