output "bucket_id" {
  value       = aws_s3_bucket.this.id
  description = "ID (nome) do bucket criado."
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "ARN do bucket criado."
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.this.bucket_domain_name
  description = "Domain name do bucket (útil para origin de CloudFront)."
}
