# Terraform Block
terraform {
  required_version = "~> 1.7.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}