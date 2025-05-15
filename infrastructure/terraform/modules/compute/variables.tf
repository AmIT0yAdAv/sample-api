variable "environment" {
  description = "Environment name"
}

variable "app_name" {
  description = "Application name"
}

variable "aws_region" {
  description = "AWS region"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
}

variable "image_tag" {
  description = "Docker image tag"
  default     = "latest"
}

variable "container_port" {
  description = "Container port"
  default     = 3000
}

variable "container_cpu" {
  description = "Container CPU units"
  default     = "256"
}

variable "container_memory" {
  description = "Container memory"
  default     = "512"
}

variable "service_desired_count" {
  description = "Desired number of tasks"
  default     = 2
}

variable "service_min_count" {
  description = "Minimum number of tasks"
  default     = 1
}

variable "service_max_count" {
  description = "Maximum number of tasks"
  default     = 4
}

variable "db_credentials_secret_arn" {
  description = "ARN of the secret containing database credentials"
}
