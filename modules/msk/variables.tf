variable "name" {
  type        = string
  description = "Prefixo do nome dos recursos (cluster, log group, SG)."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde o security group é criado."
}

variable "subnet_ids" {
  type        = list(string)
  description = "IDs das subnets (privadas) dos brokers — 1 broker é criado por subnet (regra da AWS: number_of_broker_nodes precisa ser múltiplo do número de client_subnets)."

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "subnet_ids precisa de pelo menos 2 subnets em AZs diferentes."
  }
}

variable "kafka_version" {
  type        = string
  description = "Versão do Kafka."
  default     = "3.8.x"
}

variable "broker_instance_type" {
  type        = string
  description = "Tipo de instância dos brokers."
  default     = "kafka.t3.small"
}

variable "ebs_volume_size" {
  type        = number
  description = "Tamanho (GB) do EBS de cada broker."
  default     = 100
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Blocos CIDR liberados na porta TLS do broker (9094)."
  default     = []
}

variable "allowed_security_group_ids" {
  type        = list(string)
  description = "Security groups liberados na porta TLS do broker (9094)."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas aos recursos."
  default     = {}
}
