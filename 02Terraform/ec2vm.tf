# Create EC2 Virtual Machine Instance
resource "aws_instance" "tf-ec2vm" {
  ami               = "ami-0d7a109bf30624c99"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-ec2vm"
  }
}