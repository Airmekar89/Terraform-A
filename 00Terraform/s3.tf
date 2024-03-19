resource "aws_s3_bucket" "tf-s3bucket" {
  bucket = "tf-s3bucket-01"
  tags = {
    Name        = "tf-s3bucket"
    Environment = "Dev"
  }
}