terraform {
  required_version = ">= 1.5"
  #backend "local" {}
  backend "s3" {
    bucket = "terraform-state-6374-2358-8384"
    key    = "tf-hw/dev/terraform.tfstate"
    region = "eu-west-1"
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
