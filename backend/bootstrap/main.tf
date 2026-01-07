
variable "state_bucket" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "lock_table" {
  description = "DynamoDB table name for state locking"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "project" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

locals {
  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket" "tf_state" {
  bucket = var.state_bucket
  tags   = merge(local.tags, { Name = var.state_bucket })
}

resource "aws_s3_bucket_versioning" "tf_state_ver" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_sse" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state_block" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = var.lock_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(local.tags, { Name = var.lock_table })
}

output "state_bucket_name" {
  value = aws_s3_bucket.tf_state.id
}

output "lock_table_name" {
  value = aws_dynamodb_table.tf_lock.name
}
