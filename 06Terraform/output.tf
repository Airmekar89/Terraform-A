output "vpc_cidr" {
  value = aws_vpc.tf-Vpc.cidr_block
}
output "pub_subnet_cidr" {
  value = aws_subnet.tf-subnet-pub[*].cidr_block
}
output "ec2_instance_privateip_on_pub_subnet" {
  value = aws_instance.tf-ec2vm-pub[*].private_ip
}
output "ec2_instance_publicip_on_pub_subnet" {
  value = aws_instance.tf-ec2vm-pub[*].public_ip
}
output "priv_subnet_cidr" {
  value = aws_subnet.tf-subnet-priv[*].cidr_block
}
output "ec2_instance_privateip_on_priv_subnet" {
  value = aws_instance.tf-ec2vm-priv[*].private_ip
}