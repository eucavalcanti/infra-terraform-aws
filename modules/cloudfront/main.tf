resource "aws_cloudfront_origin_access_control" "this" {
  count = var.use_s3_origin_access_control ? 1 : 0

  name                              = "${var.name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  price_class         = var.price_class
  default_root_object = var.default_root_object
  tags                = var.tags

  origin {
    domain_name = var.origin_domain_name
    origin_id   = "origin"

    dynamic "custom_origin_config" {
      for_each = var.use_s3_origin_access_control ? [] : [1]
      content {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }

    origin_access_control_id = var.use_s3_origin_access_control ? aws_cloudfront_origin_access_control.this[0].id : null
  }

  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id       = "origin"
    viewer_protocol_policy = var.viewer_protocol_policy
    compress               = var.compress
    min_ttl                = 0
    default_ttl            = var.default_ttl
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
