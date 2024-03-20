# Create S3 bucket per environment with for_each and maps
resource "aws_s3_bucket" "tfs3bucket" {
  for_each = {
    dev = "tf-dvapp-bucket"
    qa = "tf-qapp-bucket"
    prod = "tf-prdapp-bucket"
  }
  bucket = "${each.key}-${each.value}"
  tags = {
    #eachvalue = each.value
  #Environment = each.key 
  bucketname = "${each.key}-${each.value}"
  }
}