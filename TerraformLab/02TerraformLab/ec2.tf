# Resource: EC2 Instance
resource "aws_instance" "tf-ec2" {
  ami           = "ami-04ff98ccbfa41c9ad"
  instance_type = "t2.micro"
  key_name      = "terraform-key"
 # security_groups = [ aws_security_group.vpc-ssh.id , aws_security_group.vpc-web.id ]
  user_data     = file("${path.module}/app1-install.sh")
  tags = {
    Name = "tf-ec2"
  }
  depends_on = [ aws_key_pair.key_pair ]
}
resource "tls_private_key" "priv_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key_pair" {
  key_name   = "terraform-key"
  public_key = tls_private_key.priv_key.public_key_openssh
}
resource "local_file" "ssh_key" {
  filename        = "${aws_key_pair.key_pair.key_name}.pem"
  file_permission = "0400"
  content         = tls_private_key.priv_key.private_key_pem
}
/*
resource "aws_key_pair" "key_pair" {
  key_name = "terraform-key"
  public_key = tls_private_key.priv_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.priv_key.private_key_pem}' >.terraform-key.pem"
  }
}
*/