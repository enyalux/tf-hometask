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




resource "aws_security_group" "sg_ec2_access" {
  name   = "sg-ec2-access"
  vpc_id = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "sg_ec2_access" {
  security_group_id = aws_security_group.sg_ec2_access.id

  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
#  referenced_security_group_id = aws_security_group.lb_public_access.id
}

resource "aws_vpc_security_group_egress_rule" "ec2_internet_access" {
  for_each          = toset(["80", "443"])
  security_group_id = aws_security_group.sg_ec2_access.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = each.value
  ip_protocol = "tcp"
  to_port     = each.value

  tags = {
    "Name" = "internet access to port ${each.value}"
  }
}

