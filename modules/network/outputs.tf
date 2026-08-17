output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID da VPC criada."
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "Bloco CIDR da VPC."
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "IDs das subnets públicas (uma por AZ)."
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "IDs das subnets privadas (uma por AZ)."
}

output "availability_zones" {
  value       = local.azs
  description = "Availability Zones usadas."
}
