
module "vpc" {
  source             = "./modules/vpc"
  project            = var.project
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  az                 = var.az
  tags               = var.tags
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  tags        = var.tags
}

module "ec2" {
  source                 = "./modules/ec2"
  project                = var.project
  environment            = var.environment
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.vpc.web_sg_id]
  instance_type          = var.instance_type
  tags                   = var.tags
}
