output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "cloudfront_www_domain_name" {
  description = "CloudFront distribution domain name for www"
  value       = aws_cloudfront_distribution.www.domain_name
}

output "cloudfront_www_id" {
  description = "CloudFront distribution ID for www"
  value       = aws_cloudfront_distribution.www.id
}

output "cloudfront_docs_domain_name" {
  description = "CloudFront distribution domain name for docs"
  value       = aws_cloudfront_distribution.docs.domain_name
}

output "cloudfront_docs_id" {
  description = "CloudFront distribution ID for docs"
  value       = aws_cloudfront_distribution.docs.id
}

output "www_url" {
  description = "URL for www site"
  value       = "https://www.${var.domain_name}"
}

output "docs_url" {
  description = "URL for docs site"
  value       = "https://docs.${var.domain_name}"
}

output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.main.arn
}
