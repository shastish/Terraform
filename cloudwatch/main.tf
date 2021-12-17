#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAWQ6CFPKVYENJ26DL"
  secret_key = "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"
}
#######################################################
#Creating Alram for CPU utilization

resource "aws_cloudwatch_metric_alarm" "cpu-utilization" {
  alarm_name          = "high-cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = ["arn:aws:sns:us-east-2:448694418091:alarms-topic"] //change with Topic arn

  dimensions = {
    InstanceId = "i-084c3a673abe63e29" //change the instance id
  }
}
#####################################################################
#Creating Alram for instancec helath check
resource "aws_cloudwatch_metric_alarm" "instance-health-check" {
  alarm_name          = "instance-health-check"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 health status"
  alarm_actions       = ["arn:aws:sns:us-east-2:448694418091:alarms-topic"] //change with Topic arn

  dimensions = {
    InstanceId = "i-084c3a673abe63e29" //change the instance id
  }
}
