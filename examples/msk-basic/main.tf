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

  name = "exemplo-msk-basic"
}

module "msk" {
  source = "../../modules/msk"

  name       = "exemplo-msk-basic"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids

  allowed_cidr_blocks = [module.network.vpc_cidr_block]

  tags = {
    Project   = "exemplo-msk-basic"
    ManagedBy = "terraform"
  }
}

output "bootstrap_brokers_tls" {
  value = module.msk.bootstrap_brokers_tls
}
