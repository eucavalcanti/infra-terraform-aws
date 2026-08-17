variable "name" {
  type        = string
  description = "Prefixo do nome dos recursos (launch template, ASG, role, SG)."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde o security group é criado."
}

variable "subnet_ids" {
  type        = list(string)
  description = "IDs das subnets (privadas) onde as instâncias são lançadas."
}

variable "instance_type" {
  type        = string
  description = "Tipo das instâncias."
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
  description = "Tamanho (GB) do volume raiz de cada instância."
  default     = 20
}

variable "min_size" {
  type        = number
  description = "Tamanho mínimo do grupo."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Tamanho máximo do grupo."
  default     = 3
}

variable "desired_capacity" {
  type        = number
  description = "Capacidade desejada inicial."
  default     = 1
}

variable "target_cpu_utilization" {
  type        = number
  description = "Alvo (%) de utilização de CPU pra política de target tracking."
  default     = 60
}

variable "target_group_arns" {
  type        = list(string)
  description = "ARNs de target groups pra anexar (ex: module.alb.target_group_arn). Vazio = ASG sem load balancer."
  default     = []
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
