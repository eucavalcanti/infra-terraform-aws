output "domain_name" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "Domain name da distribuição CloudFront."
}

output "distribution_id" {
  value       = aws_cloudfront_distribution.this.id
  description = "ID da distribuição CloudFront."
}

output "distribution_arn" {
  value       = aws_cloudfront_distribution.this.arn
  description = "ARN da distribuição CloudFront (usado em bucket policy com OAC)."
}
