resource "aws_sqs_queue" "dlq" {
  count = var.dead_letter_queue_enabled ? 1 : 0

  name                      = var.fifo ? "${var.name}-dlq.fifo" : "${var.name}-dlq"
  fifo_queue                = var.fifo
  message_retention_seconds = var.message_retention_seconds

  tags = var.tags
}

resource "aws_sqs_queue" "this" {
  name                        = var.fifo ? "${var.name}.fifo" : var.name
  fifo_queue                  = var.fifo
  content_based_deduplication = var.fifo ? var.content_based_deduplication : null
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = var.message_retention_seconds
  delay_seconds               = var.delay_seconds

  redrive_policy = var.dead_letter_queue_enabled ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  tags = var.tags
}
