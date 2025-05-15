variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  default     = "dev"
}

variable "app_name" {
  description = "Application name"
  default     = "sample-node-api"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.1.0.0/16"
}

variable "public_subnets_cidr" {
  description = "Public subnets CIDR blocks"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "Private subnets CIDR blocks"
  type        = list(string)
  default     = ["10.1.10.0/24", "10.1.11.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
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
  default     = 1
}

variable "service_min_count" {
  description = "Minimum number of tasks"
  default     = 1
}

variable "service_max_count" {
  description = "Maximum number of tasks"
  default     = 2
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  default     = 20
}

variable "db_instance_class" {
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  default     = "app_dev"
}

variable "db_username" {
  description = "Database username"
  default     = "app_user"
}

variable "db_password" {
  description = "Database password"
  default     = ""
  sensitive   = true
}
