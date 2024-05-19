resource "aws_eip" "tf-eip" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.tf-igw]
}