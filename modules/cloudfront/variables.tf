variable "name" {
  type        = string
  description = "Prefixo usado no nome dos recursos (ex: origin access control)."
}

variable "origin_domain_name" {
  type        = string
  description = "Domain name da origem (bucket S3 ou origem HTTP custom)."
}

variable "use_s3_origin_access_control" {
  type        = bool
  description = "true = origem é um bucket S3 privado, cria Origin Access Control. false = origem é um endpoint HTTPS custom."
  default     = false
}

variable "price_class" {
  type        = string
  description = "Price class da distribuição."
  default     = "PriceClass_100"

  validation {
    condition     = contains(["PriceClass_100", "PriceClass_200", "PriceClass_All"], var.price_class)
    error_message = "price_class deve ser PriceClass_100, PriceClass_200 ou PriceClass_All."
  }
}

variable "default_root_object" {
  type        = string
  description = "Objeto padrão servido na raiz."
  default     = "index.html"
}

variable "viewer_protocol_policy" {
  type        = string
  description = "Política de protocolo do viewer."
  default     = "redirect-to-https"

  validation {
    condition     = contains(["allow-all", "redirect-to-https", "https-only"], var.viewer_protocol_policy)
    error_message = "viewer_protocol_policy deve ser allow-all, redirect-to-https ou https-only."
  }
}

variable "allowed_methods" {
  type        = list(string)
  description = "Métodos HTTP permitidos no cache behavior padrão."
  default     = ["GET", "HEAD"]
}

variable "cached_methods" {
  type        = list(string)
  description = "Métodos HTTP cacheados no cache behavior padrão."
  default     = ["GET", "HEAD"]
}

variable "compress" {
  type        = bool
  description = "Habilita compressão automática de conteúdo."
  default     = true
}

variable "default_ttl" {
  type        = number
  description = "TTL padrão (segundos) do cache."
  default     = 86400
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas à distribuição."
  default     = {}
}
