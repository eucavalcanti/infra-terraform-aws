output "queue_url" {
  value       = aws_sqs_queue.this.url
  description = "URL da fila principal."
}

output "queue_arn" {
  value       = aws_sqs_queue.this.arn
  description = "ARN da fila principal."
}

output "dlq_url" {
  value       = var.dead_letter_queue_enabled ? aws_sqs_queue.dlq[0].url : null
  description = "URL da dead-letter queue, ou null se desabilitada."
}

output "dlq_arn" {
  value       = var.dead_letter_queue_enabled ? aws_sqs_queue.dlq[0].arn : null
  description = "ARN da dead-letter queue, ou null se desabilitada."
}
