variable "environment" {
  description = "Environment name"
}

variable "app_name" {
  description = "Application name"
}

variable "vpc_id" {
  description = "VPC ID where the database will be deployed"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "app_security_group_id" {
  description = "Security group ID of the application"
}

variable "allocated_storage" {
  description = "Allocated storage for the database in GB"
  default     = 20
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  default     = "13.7"
}

variable "instance_class" {
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  default     = "appdb"
}

variable "db_username" {
  description = "Database username"
  default     = "appuser"
}

variable "db_password" {
  description = "Database password, if not provided a random one will be generated"
  default     = ""
  sensitive   = true
}

variable "db_port" {
  description = "Database port"
  default     = 5432
}
