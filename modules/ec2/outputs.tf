output "instance_id" {
  value       = aws_instance.this.id
  description = "ID da instância EC2."
}

output "private_ip" {
  value       = aws_instance.this.private_ip
  description = "IP privado da instância."
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "ID do security group da instância — use em allowed_security_group_ids de outros módulos que precisem acessá-la."
}
