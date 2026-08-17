variable "name" {
  type        = string
  description = "Nome/identifier da instância RDS."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde a instância e o security group são criados."
}

variable "subnet_ids" {
  type        = list(string)
  description = "IDs das subnets (privadas) para o DB subnet group. Mínimo 2, em AZs diferentes."

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "subnet_ids precisa de pelo menos 2 subnets em AZs diferentes."
  }
}

variable "engine_version" {
  type        = string
  description = "Versão do PostgreSQL."
  default     = "16"
}

variable "instance_class" {
  type        = string
  description = "Classe da instância RDS."
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Storage alocado (GB)."
  default     = 20
}

variable "db_name" {
  type        = string
  description = "Nome do banco de dados criado na instância."
  default     = "appdb"
}

variable "username" {
  type        = string
  description = "Usuário master do banco."
  default     = "app_user"
}

variable "password" {
  type        = string
  description = "Senha do usuário master."
  sensitive   = true
}

variable "port" {
  type        = number
  description = "Porta do PostgreSQL."
  default     = 5432
}

variable "multi_az" {
  type        = bool
  description = "Habilita Multi-AZ."
  default     = false
}

variable "backup_retention_days" {
  type        = number
  description = "Dias de retenção de backup. 0 desabilita snapshot final."
  default     = 7
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Blocos CIDR liberados na porta do banco."
  default     = []
}

variable "allowed_security_group_ids" {
  type        = list(string)
  description = "Security groups liberados na porta do banco (ex: SG de uma aplicação)."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas aos recursos."
  default     = {}
}
