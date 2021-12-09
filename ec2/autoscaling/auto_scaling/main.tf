resource "aws_launch_configuration" "apache-config" {
  name          = "apache1_config"
  image_id        = "ami-083654bd07b5da81d" //change
  instance_type   = "t2.micro"
  security_groups = ["sg-005378d0f822d7ecc"] //change

}
resource "aws_autoscaling_group" "apache_asg" {
  name = "Apache_asg"
  launch_configuration = "${aws_launch_configuration.apache-config.name}"
  vpc_zone_identifier  = ["${var.subnet1}","${var.subnet2 }"]
  target_group_arns    = ["${var.target_group_arn}"]
  health_check_type    = "ELB"
  min_size = 1
  max_size = 2
  desired_capacity          = 2
  health_check_grace_period = 60
  force_delete              = true

  tag  {
    key                 = "Name"
    value               = "apache-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = aws_autoscaling_group.apache_asg.id
  alb_target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:326717932327:targetgroup/apache-tg/b9cce9a5dcaefe68" //change
}
output "auto_scaling_group_id" {
  value = "aws_autoscaling_group.apache_asg1.id" 
  
}
