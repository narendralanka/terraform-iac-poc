
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "ec2_public_ip" {
  value       = module.ec2.public_ip
  description = "Public IP of the EC2 instance"
}

output "s3_bucket_arn" {
  value       = module.s3.bucket_arn
  description = "ARN of the S3 bucket"
}
