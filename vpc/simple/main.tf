#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAS7T2UNA2JPC2QIV6"
  secret_key = "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"
}
#######################################################
#Creating Production VPC with CIDR: 172.16.0.0/16
resource "aws_vpc" "vpc" {
    cidr_block = "172.16.0.0/16" 
    tags = {
        Name = "UAT VPC"
    }
}
output "vpcid" {
  value = aws_vpc.vpc.id
}
###########################################################
