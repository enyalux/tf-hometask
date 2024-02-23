terraform {
  required_version = ">= 1.5"
  #backend "local" {}
  backend "s3" {
    #  bucket = "terraform-state-6374-2358-8384"
    #  key    = "tf-hw/dev/terraform.tfstate"
    #  region = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = [var.aws_credentials_path]
  profile                  = var.aws_profile
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name = "TF-vpc"
  cidr = "10.0.0.0/16"
  #azs = [ "eu-west-1a", "eu-west-1b", "eu-west-1c"]
  azs = [for i in ["a", "b", "c"] : "${var.region}${i}"]

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_ipv6        = false
}
