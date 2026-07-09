terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
  backend "s3" {
    bucket = "locate360-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "../../modules/vpc"
  name_prefix         = var.name_prefix
  vpc_cidr            = "10.20.0.0/16"
  public_subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
  azs                 = ["${var.aws_region}a", "${var.aws_region}b"]
  allowed_ssh_cidrs   = var.allowed_ssh_cidrs
  tags                = var.tags
}

module "ec2" {
  source             = "../../modules/ec2"
  name_prefix        = var.name_prefix
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_id  = module.vpc.k8s_sg_id
  ssh_public_key     = var.ssh_public_key
  worker_count       = 2
  tags               = var.tags
}

module "s3_cloudfront" {
  source      = "../../modules/s3-cloudfront"
  bucket_name = var.frontend_bucket_name
  tags        = var.tags
}
