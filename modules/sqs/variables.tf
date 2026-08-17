variable "name" {
  type        = string
  description = "Nome base da fila (vira \"<name>\" ou \"<name>.fifo\")."
}

variable "fifo" {
  type        = bool
  description = "Cria uma fila FIFO em vez de standard."
  default     = false
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "Tempo (segundos) que uma mensagem fica invisível após ser lida."
  default     = 30
}

variable "message_retention_seconds" {
  type        = number
  description = "Tempo (segundos) de retenção das mensagens."
  default     = 345600
}

variable "delay_seconds" {
  type        = number
  description = "Atraso (segundos) antes de uma mensagem ficar visível."
  default     = 0
}

variable "content_based_deduplication" {
  type        = bool
  description = "Deduplicação baseada em conteúdo — só tem efeito se fifo = true."
  default     = false
}

variable "dead_letter_queue_enabled" {
  type        = bool
  description = "Cria uma dead-letter queue e associa via redrive_policy."
  default     = true
}

variable "max_receive_count" {
  type        = number
  description = "Tentativas antes de mover a mensagem pra dead-letter queue."
  default     = 5
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas às filas."
  default     = {}
}
