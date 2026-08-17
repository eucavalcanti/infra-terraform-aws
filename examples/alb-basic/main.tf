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

  name = "exemplo-alb-basic"
}

module "alb" {
  source = "../../modules/alb"

  name       = "exemplo-alb-basic"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.public_subnet_ids

  tags = {
    Project   = "exemplo-alb-basic"
    ManagedBy = "terraform"
  }
}

output "alb_dns_name" {
  value = module.alb.dns_name
}
