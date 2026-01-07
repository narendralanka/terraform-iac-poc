provider "aws" {
  region = var.region
  # Optionally: default tags for all resources
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
