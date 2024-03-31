# Terraform Block
terraform {
  required_version = "~> 1.7.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }
  #Adding Backend using s3 for Remote State Storage
  /*
  backend "s3" {
    bucket = "mytfs3bucket" #s3 bucket must have been previously created.
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    # For State Locking, must have created dynamodb table prior, with "LockID" as partition key or Primary key
    dynamodb_table = "tf-dev-state-table"
  }
*/
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}