variable "name" {
  type        = string
  description = "Prefixo do nome dos recursos (ALB, target group, SG)."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde o ALB e o security group são criados."
}

variable "subnet_ids" {
  type        = list(string)
  description = "IDs das subnets onde o ALB é lançado — públicas se internal = false, privadas se internal = true."

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "subnet_ids precisa de pelo menos 2 subnets em AZs diferentes."
  }
}

variable "internal" {
  type        = bool
  description = "true = ALB interno (subnets privadas). false = ALB público (subnets públicas)."
  default     = false
}

variable "target_port" {
  type        = number
  description = "Porta de destino do target group."
  default     = 80
}

variable "health_check_path" {
  type        = string
  description = "Path do health check HTTP."
  default     = "/"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Blocos CIDR liberados na porta 80 do ALB."
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas aos recursos."
  default     = {}
}
