#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT3O737FHG"
  secret_key = "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"
}
#######################################################
#Creating Production VPC with CIDR: 10.0.0.0/16
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16" 
    tags = {
        Name = "Prodction VPC"
    }
}
output "vpcid" {
  value = aws_vpc.vpc.id
}
