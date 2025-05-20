provider "aws" {
  region = var.region
}

resource "aws_secretsmanager_secret" "aurora_secret" {
  name = "aurora-db-credentials"
}

resource "aws_secretsmanager_secret_version" "aurora_secret_version" {
  secret_id     = aws_secretsmanager_secret.aurora_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  master_username         = var.db_username
  master_password         = var.db_password
  database_name           = var.db_name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = 2
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.aurora.engine
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "db_sg" {
  name        = "aurora-db-sg"
  description = "Allow DB access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}