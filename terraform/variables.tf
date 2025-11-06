variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "codingchallenge.ai"
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for hosting static content"
  type        = string
  default     = "www.codingchallenge.ai"
}
