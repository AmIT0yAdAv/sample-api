# Create a security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  # Allow inbound traffic only from the application security group
  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-rds-sg"
    Environment = var.environment
  }
}

# Create a subnet group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.environment}-rds-subnet-group"
  description = "Subnet group for RDS"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name        = "${var.environment}-rds-subnet-group"
    Environment = var.environment
  }
}

# Create random password for RDS if not provided
resource "random_password" "db_password" {
  count   = var.db_password == "" ? 1 : 0
  length  = 16
  special = false
}

# Create AWS Secrets Manager secret for database credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.environment}/${var.app_name}/db-credentials"
  description = "Database credentials for ${var.app_name} application"

  tags = {
    Name        = "${var.environment}-${var.app_name}-db-credentials"
    Environment = var.environment
  }
}

# Store database credentials in AWS Secrets Manager
resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username,
    password = var.db_password == "" ? random_password.db_password[0].result : var.db_password,
    host     = aws_db_instance.main.address,
    port     = var.db_port,
    dbname   = var.db_name
  })
}

# Create the RDS instance
resource "aws_db_instance" "main" {
  identifier              = "${var.environment}-${var.app_name}-db"
  allocated_storage       = var.allocated_storage
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password == "" ? random_password.db_password[0].result : var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = false
  skip_final_snapshot     = var.environment != "prod"
  final_snapshot_identifier = var.environment == "prod" ? "${var.environment}-${var.app_name}-db-final-snapshot" : null
  deletion_protection     = var.environment == "prod"
  backup_retention_period = var.environment == "prod" ? 7 : 1
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  multi_az                = var.environment == "prod"
  
  tags = {
    Name        = "${var.environment}-${var.app_name}-db"
    Environment = var.environment
  }
}
