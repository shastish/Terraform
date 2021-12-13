resource "aws_lb_target_group" "apache-target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "apache-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0ba27102c0570d4dd" //chnage the vpc id
}

output "Target_group_arn"{
  value = "aws_lb_target_group.apache-target-group.arn"
}

resource "aws_lb_target_group_attachment" "apache-alb-target-group-attachment1" {
  target_group_arn = "${aws_lb_target_group.apache-target-group.arn}"
  target_id        = "i-09f7594b997b9e28e" //change your instance ID
  port             = 80
}
resource "aws_lb_target_group_attachment" "apache-alb-target-group-attachment2" {
  target_group_arn = "${aws_lb_target_group.apache-target-group.arn}"
  target_id        = "i-028ea9afb9a404698" //change your instance ID
  port             = 80
}

resource "aws_lb" "apache-alb" {
  name     = "apache-alb"
  internal = false

  security_groups = [
    "sg-005378d0f822d7ecc", //change the SG id
  ]

  subnets = [
    "subnet-0c7c1bc41cf0b7e93", //change subnet id AZ1A
    "subnet-0efa44c305c444ca4", //change subnet id AZ1B
  ]

  tags = {
    Name = "apache-alb"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "apache-alb-listner" {
  load_balancer_arn = "${aws_lb.apache-alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.apache-target-group.arn}"
  }
}

