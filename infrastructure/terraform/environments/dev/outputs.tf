output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "ecr_repository_url" {
  description = "ECR Repository URL"
  value       = module.ecr.repository_url
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.compute.alb_dns_name
}

output "db_endpoint" {
  description = "Database endpoint"
  value       = module.database.db_instance_endpoint
}

output "db_credentials_secret_arn" {
  description = "ARN of the secret containing database credentials"
  value       = module.database.db_credentials_secret_arn
}
