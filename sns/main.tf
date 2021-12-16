#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAWQ6CFPKVYENJ26DL"
  secret_key = "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"
}
#######################################################
resource "aws_sns_topic" "alarm" {
  name = "alarms-topic"

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}
resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.alarm.arn
  protocol  = "email"
  endpoint  = "umeshbalaji.qtreetechnologies@gmail.com" //change your E-mail
}
