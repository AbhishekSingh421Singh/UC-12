output "db_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "secret_arn" {
  value = aws_secretsmanager_secret.aurora_secret.arn
}