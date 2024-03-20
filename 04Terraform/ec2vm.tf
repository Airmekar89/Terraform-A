# Create Ec2 virtual machine Instance
resource "aws_instance" "tf-ec2vm-pub" {
  count         = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  ami           = data.aws_ami.amzn-Linux2.id
  instance_type = "t2.micro"
  key_name      = "LM-Class32"
  user_data     = file("apache.sh")

  subnet_id       = aws_subnet.tf-subnet-pub.*.id[count.index]
  security_groups = [aws_security_group.tf-sg.id]
  tags = {
    Name = "tf-ec2vm-pub-[count.index]"

  }
}
resource "aws_instance" "tf-ec2vm-priv" {
  count         = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  ami           = data.aws_ami.amzn-Linux2.id 
  instance_type = "t2.micro"
  key_name      = "LM-Class32"

  subnet_id       = aws_subnet.tf-subnet-priv.*.id[count.index]
  security_groups = [aws_security_group.tf-sg.id]
  tags = {
    Name = "tf-ec2vm-priv-[count.index]"

  }
}