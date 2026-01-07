
project             = "iac-poc"
environment         = "dev"
region              = "ap-south-1"

vpc_cidr            = "10.10.0.0/16"
public_subnet_cidr  = "10.10.1.0/24"
az                  = "ap-south-1a"

instance_type       = "t3.micro"

# Change to a globally unique name (S3 bucket names are global)
bucket_name         = "iac-poc-dev-bucket-123456"

# Optional additional tags
tags = {
  Owner = "Narendranadh Lanka"
}
