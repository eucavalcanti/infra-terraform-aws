variable "name" {
  type        = string
  description = "Prefixo do nome dos recursos (instância, role, SG)."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde o security group é criado."
}

variable "subnet_id" {
  type        = string
  description = "ID da subnet (privada) onde a instância é lançada."
}

variable "instance_type" {
  type        = string
  description = "Tipo da instância EC2."
  default     = "t3.small"
}

variable "ami_id" {
  type        = string
  description = "AMI a usar. Vazio = Amazon Linux 2023 mais recente."
  default     = ""
}

variable "app_port" {
  type        = number
  description = "Porta da aplicação liberada no security group."
  default     = 8080
}

variable "root_volume_size" {
  type        = number
  description = "Tamanho (GB) do volume raiz."
  default     = 20
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Blocos CIDR liberados em app_port."
  default     = []
}

variable "allowed_security_group_ids" {
  type        = list(string)
  description = "Security groups liberados em app_port (ex: SG de um ALB)."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas aos recursos."
  default     = {}
}
