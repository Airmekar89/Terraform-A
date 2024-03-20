# Create EC2 Instance
resource "aws_instance" "tf-ec2vm" {
  ami               = "ami-0d7a109bf30624c99" #amazon linux
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "LM-Class32"
  tags = {
    Name = "tf-ec2vm"
    Env = "Dev"
  }
}