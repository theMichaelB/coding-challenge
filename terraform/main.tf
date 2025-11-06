# Data source for existing Route53 hosted zone
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

# S3 Bucket for static website hosting
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = {
    project = "codingchallenge"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "website" {
  name                              = "${var.bucket_name}-oac"
  description                       = "OAC for ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# S3 Bucket Policy to allow CloudFront access
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.website.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = [
              aws_cloudfront_distribution.www.arn,
              aws_cloudfront_distribution.docs.arn
            ]
          }
        }
      }
    ]
  })
}

# ACM Certificate for SSL/TLS (must be in us-east-1 for CloudFront)
resource "aws_acm_certificate" "main" {
  provider          = aws.us_east_1
  domain_name       = var.domain_name
  subject_alternative_names = [
    "*.${var.domain_name}"
  ]
  validation_method = "DNS"

  tags = {
    project = "codingchallenge"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Route53 records for ACM certificate validation
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

# ACM certificate validation
resource "aws_acm_certificate_validation" "main" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# CloudFront Distribution for www.codingchallenge.ai
resource "aws_cloudfront_distribution" "www" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for www.${var.domain_name}"
  default_root_object = "index.html"
  aliases             = ["www.${var.domain_name}"]
  price_class         = "PriceClass_100"

  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = "S3-www"
    origin_path              = "/www"
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-www"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.main.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/index.html"
  }

  tags = {
    project = "codingchallenge"
  }

  depends_on = [aws_acm_certificate_validation.main]
}

# CloudFront Distribution for docs.codingchallenge.ai
resource "aws_cloudfront_distribution" "docs" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for docs.${var.domain_name}"
  default_root_object = "index.html"
  aliases             = ["docs.${var.domain_name}"]
  price_class         = "PriceClass_100"

  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = "S3-docs"
    origin_path              = "/docs"
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-docs"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.main.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/index.html"
  }

  tags = {
    project = "codingchallenge"
  }

  depends_on = [aws_acm_certificate_validation.main]
}

# Route53 A record for www.codingchallenge.ai
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www.domain_name
    zone_id                = aws_cloudfront_distribution.www.hosted_zone_id
    evaluate_target_health = false
  }
}

# Route53 A record for docs.codingchallenge.ai
resource "aws_route53_record" "docs" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "docs.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.docs.domain_name
    zone_id                = aws_cloudfront_distribution.docs.hosted_zone_id
    evaluate_target_health = false
  }
}

# Upload www index.html to S3
resource "aws_s3_object" "www_index" {
  bucket       = aws_s3_bucket.website.id
  key          = "www/index.html"
  source       = "${path.module}/../www/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/../www/index.html")

  tags = {
    project = "codingchallenge"
  }
}

# Upload docs index.html to S3
resource "aws_s3_object" "docs_index" {
  bucket       = aws_s3_bucket.website.id
  key          = "docs/index.html"
  source       = "${path.module}/../docs/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/../docs/index.html")

  tags = {
    project = "codingchallenge"
  }
}
