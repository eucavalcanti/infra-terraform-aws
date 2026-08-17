output "table_name" {
  value       = aws_dynamodb_table.this.name
  description = "Nome da tabela criada."
}

output "table_arn" {
  value       = aws_dynamodb_table.this.arn
  description = "ARN da tabela criada."
}
