output "bootstrap_brokers_tls" {
  value       = aws_msk_cluster.this.bootstrap_brokers_tls
  description = "Endpoints TLS dos brokers pra conexão de clientes Kafka."
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "ID do security group do cluster."
}
