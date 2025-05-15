provider "aws" {
  region = var.aws_region
}

# Set up Terraform state backend with S3
terraform {
  backend "s3" {
    bucket  = "sample-node-api-terraform-state"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# ECR Repository
module "ecr" {
  source = "../../modules/ecr"
  
  environment     = var.environment
  app_name        = var.app_name
  aws_account_ids = [data.aws_caller_identity.current.account_id]
}

# VPC and Networking
module "networking" {
  source = "../../modules/networking"
  
  environment           = var.environment
  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  public_subnets_cidr   = var.public_subnets_cidr
  private_subnets_cidr  = var.private_subnets_cidr
  availability_zones    = var.availability_zones
}

# ECS Compute Resources
module "compute" {
  source = "../../modules/compute"
  
  environment              = var.environment
  app_name                 = var.app_name
  aws_region               = var.aws_region
  vpc_id                   = module.networking.vpc_id
  public_subnet_ids        = module.networking.public_subnets_ids
  private_subnet_ids       = module.networking.private_subnets_ids
  ecr_repository_url       = module.ecr.repository_url
  image_tag                = var.image_tag
  container_port           = var.container_port
  container_cpu            = var.container_cpu
  container_memory         = var.container_memory
  service_desired_count    = var.service_desired_count
  service_min_count        = var.service_min_count
  service_max_count        = var.service_max_count
  db_credentials_secret_arn = module.database.db_credentials_secret_arn
}

# RDS Database
module "database" {
  source = "../../modules/database"
  
  environment           = var.environment
  app_name              = var.app_name
  vpc_id                = module.networking.vpc_id
  private_subnet_ids    = module.networking.private_subnets_ids
  app_security_group_id = module.compute.service_security_group_id
  allocated_storage     = var.db_allocated_storage
  instance_class        = var.db_instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
}
