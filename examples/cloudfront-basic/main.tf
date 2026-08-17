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

  bucket_name         = "exemplo-cloudfront-basic-bucket"
  block_public_access = true
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  name                         = "exemplo-cloudfront-basic"
  origin_domain_name           = module.s3.bucket_domain_name
  use_s3_origin_access_control = true
  tags = {
    Project   = "exemplo-cloudfront-basic"
    ManagedBy = "terraform"
  }
}

# Origin Access Control só funciona com o bucket liberando o principal do
# CloudFront — isso não é responsabilidade do módulo cloudfront (ele não
# possui o bucket), fica por conta de quem orquestra.
data "aws_iam_policy_document" "allow_cloudfront" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalRead"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${module.s3.bucket_arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [module.cloudfront.distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = module.s3.bucket_id
  policy = data.aws_iam_policy_document.allow_cloudfront.json
}

output "cloudfront_domain_name" {
  value = module.cloudfront.domain_name
}
