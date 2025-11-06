# Coding Challenge Infrastructure

Infrastructure as Code (IaC) for codingchallenge.ai static website hosting using AWS S3, CloudFront, and Route53.

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Route53 DNS                          │
│  - www.codingchallenge.ai  → CloudFront Distribution 1  │
│  - docs.codingchallenge.ai → CloudFront Distribution 2  │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│              CloudFront Distributions                   │
│  - Distribution 1: www  (origin path: /www)            │
│  - Distribution 2: docs (origin path: /docs)           │
│  - SSL/TLS: ACM Certificate (*.codingchallenge.ai)     │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│           S3 Bucket: www.codingchallenge.ai             │
│                                                         │
│  /www/index.html    → www.codingchallenge.ai           │
│  /docs/index.html   → docs.codingchallenge.ai          │
└─────────────────────────────────────────────────────────┘
```

## Project Structure

```
.
├── terraform/
│   ├── providers.tf    # AWS provider configuration
│   ├── variables.tf    # Input variables
│   ├── main.tf         # Main infrastructure resources
│   └── outputs.tf      # Output values
├── www/
│   └── index.html      # Main website holding page
├── docs/
│   └── index.html      # Documentation holding page
└── README.md           # This file
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- Existing Route53 hosted zone for `codingchallenge.ai`
- AWS account with permissions for:
  - S3 bucket creation and management
  - CloudFront distribution creation
  - ACM certificate management
  - Route53 record management

## AWS Resources Created

- **S3 Bucket**: `www.codingchallenge.ai` with private access
- **CloudFront OAC**: Origin Access Control for secure S3 access
- **ACM Certificate**: Wildcard cert for `*.codingchallenge.ai` and `codingchallenge.ai`
- **CloudFront Distributions**: 2 distributions (www and docs)
- **Route53 Records**:
  - A record for `www.codingchallenge.ai`
  - A record for `docs.codingchallenge.ai`
  - Validation records for ACM certificate

## Deployment Steps

### 1. Configure AWS Credentials

```bash
aws configure
```

Or set environment variables:

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 2. Initialize Terraform

```bash
cd terraform
terraform init
```

### 3. Review the Plan

```bash
terraform plan
```

This will show you all resources that will be created.

### 4. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### 5. Wait for DNS Propagation

- ACM certificate validation: ~5-10 minutes
- CloudFront distribution deployment: ~15-20 minutes
- DNS propagation: up to 48 hours (usually faster)

### 6. Verify Deployment

After deployment completes, Terraform will output the URLs:

```bash
terraform output
```

You can test the sites:

```bash
curl -I https://www.codingchallenge.ai
curl -I https://docs.codingchallenge.ai
```

## Updating Content

To update the HTML files:

1. Edit `www/index.html` or `docs/index.html`
2. Apply changes:

```bash
cd terraform
terraform apply
```

Terraform will automatically upload the changed files to S3.

3. Invalidate CloudFront cache (optional, for immediate updates):

```bash
# For www
aws cloudfront create-invalidation \
  --distribution-id $(terraform output -raw cloudfront_www_id) \
  --paths "/*"

# For docs
aws cloudfront create-invalidation \
  --distribution-id $(terraform output -raw cloudfront_docs_id) \
  --paths "/*"
```

## Cost Estimate

Approximate monthly costs (as of 2025):

- S3 Storage: ~$0.023/GB
- CloudFront: First 1TB transfer free, then $0.085/GB
- Route53: $0.50 per hosted zone + $0.40 per million queries
- ACM Certificate: Free

Estimated total: $0.50 - $5/month for low traffic

## Customization

### Change Domain Name

Edit `terraform/variables.tf`:

```hcl
variable "domain_name" {
  default = "yourdomain.com"
}
```

### Change AWS Region

Edit `terraform/variables.tf`:

```hcl
variable "aws_region" {
  default = "us-west-2"
}
```

Note: ACM certificates for CloudFront must be in `us-east-1`, which is handled by the `us_east_1` provider alias.

### Add More Subdomains

1. Add new prefix in S3 (e.g., `blog/`)
2. Create new CloudFront distribution in `main.tf`
3. Add Route53 record pointing to new distribution

## Troubleshooting

### Certificate Validation Stuck

Check Route53 records:

```bash
aws route53 list-resource-record-sets \
  --hosted-zone-id $(aws route53 list-hosted-zones \
  --query "HostedZones[?Name=='codingchallenge.ai.'].Id" \
  --output text)
```

### CloudFront Returns 403 Forbidden

- Check S3 bucket policy allows CloudFront OAC
- Verify HTML files exist at correct paths in S3
- Ensure CloudFront distribution is fully deployed

### Site Not Loading

- Check CloudFront distribution status (should be "Deployed")
- Verify DNS records point to correct CloudFront domain
- Clear browser cache or test in incognito mode

## Security Features

- ✅ S3 bucket is private (no public access)
- ✅ CloudFront Origin Access Control (OAC) for secure S3 access
- ✅ HTTPS enforced via redirect
- ✅ TLS 1.2 minimum protocol version
- ✅ No direct S3 website hosting (more secure)

## Cleanup

To destroy all resources:

```bash
cd terraform
terraform destroy
```

Type `yes` when prompted. This will remove all AWS resources created by Terraform.

**Warning**: This will delete the S3 bucket and all content. CloudFront distributions take ~15 minutes to fully delete.

## Support

For issues or questions:
- Check [AWS CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- Review [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## License

MIT
