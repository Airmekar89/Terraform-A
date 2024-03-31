# Create EC2 Instance 
resource "aws_instance" "tf-ec2vm" {
  ami = data.aws_ami.amzn-Linux2.id
  instance_type = var.instance_type
  key_name = "LM-Class32"
  count = terraform.workspace == "default" ? 2 : 1
  user_data = file("apache-install.sh")
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ]
  tags = {
    Name = "tfvm-${terraform.workspace}-${count.index}"
  }
}