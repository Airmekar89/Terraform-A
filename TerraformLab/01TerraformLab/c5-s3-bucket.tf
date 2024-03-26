# Create S3 Bucket - with Input Variables and Local Values
/*
resource "aws_s3_bucket" "mys3bucket" {
  bucket = "${var.app_name}-${var.environment_name}-bucket"
  tags = {
    Name        = "${var.app_name}-${var.environment_name}-bucket"
    Environment = var.environment_name
  }
}
*/

# Define Local Values
locals {
  bucket-name = "{var.app_name}-${var.environment_name}-bucket"
}
resource "aws_s3_bucket" "mys3bucket" {
  bucket = local.bucket-name
  tags = {
    Name        = local.bucket-name
    Environment = var.environment_name
  }
}