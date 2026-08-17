output "asg_name" {
  value       = aws_autoscaling_group.this.name
  description = "Nome do Auto Scaling Group."
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "ID do security group das instâncias do ASG."
}
