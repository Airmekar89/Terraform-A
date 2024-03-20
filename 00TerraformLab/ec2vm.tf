# practice for count meta-argument
resource "aws_instance" "tf-web" {
  ami           = "ami-02d7fd1c2af6eead0" # amz linux ami
  instance_type = "t2.micro"
  count         = 3
  tags = {
    Name = "tf-web-${count.index + 1}"
  }
}
