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
  region  = "us-east-1"
  profile = "iac_user"
}