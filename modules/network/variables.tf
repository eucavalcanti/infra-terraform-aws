variable "name" {
  type        = string
  description = "Prefixo usado no nome dos recursos de rede (VPC, subnets, IGW, NAT)."
}

variable "vpc_cidr" {
  type        = string
  description = "Bloco CIDR da VPC."
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr deve ser um bloco CIDR válido."
  }
}

variable "az_count" {
  type        = number
  description = "Número de Availability Zones — cria 1 subnet pública e 1 privada por AZ."
  default     = 2

  validation {
    condition     = var.az_count >= 2 && var.az_count <= 3
    error_message = "az_count deve ser 2 ou 3."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas a todos os recursos de rede."
  default     = {}
}
