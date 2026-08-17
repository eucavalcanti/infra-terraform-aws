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

  name = "exemplo-ec2-basic"
}

module "ec2" {
  source = "../../modules/ec2"

  name      = "exemplo-ec2-basic"
  vpc_id    = module.network.vpc_id
  subnet_id = module.network.private_subnet_ids[0]

  allowed_cidr_blocks = [module.network.vpc_cidr_block]

  tags = {
    Project   = "exemplo-ec2-basic"
    ManagedBy = "terraform"
  }
}

output "instance_id" {
  value = module.ec2.instance_id
}
