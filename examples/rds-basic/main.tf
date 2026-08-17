terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "../../modules/network"

  name = "exemplo-rds-basic"
}

variable "db_password" {
  type      = string
  sensitive = true
}

module "rds" {
  source = "../../modules/rds"

  name       = "exemplo-rds-basic"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids
  password   = var.db_password

  allowed_cidr_blocks = [module.network.vpc_cidr_block]

  tags = {
    Project   = "exemplo-rds-basic"
    ManagedBy = "terraform"
  }
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}
