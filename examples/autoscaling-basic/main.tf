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

  name = "exemplo-asg-basic"
}

module "alb" {
  source = "../../modules/alb"

  name       = "exemplo-asg-basic"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.public_subnet_ids
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  name       = "exemplo-asg-basic"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids

  target_group_arns          = [module.alb.target_group_arn]
  allowed_security_group_ids = [module.alb.security_group_id]

  tags = {
    Project   = "exemplo-asg-basic"
    ManagedBy = "terraform"
  }
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "asg_name" {
  value = module.autoscaling.asg_name
}
