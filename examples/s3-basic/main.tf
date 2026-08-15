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

module "s3" {
  source = "../../modules/s3"

  bucket_name = "exemplo-s3-basic-bucket"
  tags = {
    Project   = "exemplo-s3-basic"
    ManagedBy = "terraform"
  }
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}
