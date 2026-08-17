output "dns_name" {
  value       = aws_lb.this.dns_name
  description = "DNS name do ALB."
}

output "arn" {
  value       = aws_lb.this.arn
  description = "ARN do ALB."
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "ARN do target group — use em target_group_arns do módulo autoscaling."
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "ID do security group do ALB — use em allowed_security_group_ids do módulo autoscaling/ec2."
}
