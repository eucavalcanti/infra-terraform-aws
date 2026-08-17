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

module "sqs" {
  source = "../../modules/sqs"

  name = "exemplo-sqs-basic-queue"
  tags = {
    Project   = "exemplo-sqs-basic"
    ManagedBy = "terraform"
  }
}

output "queue_url" {
  value = module.sqs.queue_url
}
