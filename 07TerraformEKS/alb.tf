resource "aws_lb_target_group" "tf-alb" {
  name     = "tf-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tf-Vpc.id
}

resource "aws_lb_target_group_attachment" "tf-alb" {
  count            = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  target_group_arn = aws_lb_target_group.tf-alb.arn
  target_id        = aws_instance.tf-ec2vm-pub.*.id[count.index]
  port             = 80
}

resource "aws_lb" "tf-alb" {
  name               = "tf-alb-ext"
  count              = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf-sg.id]
  subnets            = [aws_subnet.tf-subnet-pub.*.id[0]]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]

  #enable_deletion_protection = true

  /*access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }
*/
  tags = {
    Name                         = "tf-alb"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "shared"
    #Environment = "production"
  }
}
#  adding the alb Listner on port 80, protocol http
resource "aws_lb_listener" "tf-alb" {
  count             = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  load_balancer_arn = aws_lb.tf-alb.*.arn[0]
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-alb.arn
  }
}