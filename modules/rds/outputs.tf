output "db_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "Endpoint (host:port) da instância."
}

output "db_instance_id" {
  value       = aws_db_instance.this.id
  description = "ID da instância RDS."
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "ID do security group da instância — use em allowed_security_group_ids de outros módulos que precisem acessar o banco."
}
