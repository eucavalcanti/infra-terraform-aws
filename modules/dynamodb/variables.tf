variable "name" {
  type        = string
  description = "Nome da tabela."
}

variable "billing_mode" {
  type        = string
  description = "Modo de cobrança."
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing_mode)
    error_message = "billing_mode deve ser PAY_PER_REQUEST ou PROVISIONED."
  }
}

variable "read_capacity" {
  type        = number
  description = "Read capacity units — só usado se billing_mode = PROVISIONED."
  default     = 5
}

variable "write_capacity" {
  type        = number
  description = "Write capacity units — só usado se billing_mode = PROVISIONED."
  default     = 5
}

variable "hash_key" {
  type        = string
  description = "Nome do atributo de partition key."
  default     = "id"
}

variable "hash_key_type" {
  type        = string
  description = "Tipo do atributo de partition key (S, N ou B)."
  default     = "S"
}

variable "range_key" {
  type        = string
  description = "Nome do atributo de sort key. Vazio desabilita."
  default     = ""
}

variable "range_key_type" {
  type        = string
  description = "Tipo do atributo de sort key (S, N ou B)."
  default     = "S"
}

variable "point_in_time_recovery" {
  type        = bool
  description = "Habilita point-in-time recovery."
  default     = false
}

variable "ttl_attribute" {
  type        = string
  description = "Nome do atributo usado como TTL. Vazio desabilita."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas à tabela."
  default     = {}
}
