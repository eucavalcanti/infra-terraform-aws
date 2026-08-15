variable "bucket_name" {
  type        = string
  description = "Nome do bucket S3 (globalmente único)."
}

variable "force_destroy" {
  type        = bool
  description = "Permite destruir o bucket mesmo com objetos dentro."
  default     = false
}

variable "block_public_access" {
  type        = bool
  description = "Bloqueia ACLs e políticas públicas no bucket."
  default     = true
}

variable "versioning" {
  type        = bool
  description = "Habilita versionamento de objetos."
  default     = true
}

variable "encryption_algorithm" {
  type        = string
  description = "Algoritmo de criptografia server-side padrão."
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.encryption_algorithm)
    error_message = "encryption_algorithm deve ser \"AES256\" ou \"aws:kms\"."
  }
}

variable "kms_key_id" {
  type        = string
  description = "ARN da KMS key, obrigatório quando encryption_algorithm = \"aws:kms\"."
  default     = null
}

variable "lifecycle_expiration_days" {
  type        = number
  description = "Dias até expirar objetos. 0 desabilita a regra de lifecycle."
  default     = 0
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas ao bucket."
  default     = {}
}
