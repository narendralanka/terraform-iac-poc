
variable "project" {
  description = "Project name for tagging and naming"
  type        = string
}

variable "environment" {
  description = "Environment identifier"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  default     = "10.10.1.0/24"
}

variable "az" {
  description = "Availability Zone for the public subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
