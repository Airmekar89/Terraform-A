resource "aws_nat_gateway" "tf-natgw" {
  count         = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  allocation_id = aws_eip.tf-eip.id
  subnet_id     = aws_subnet.tf-subnet-pub.*.id[0]
}