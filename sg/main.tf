#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT2VMCRPIK"
  secret_key = "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"
}
#######################################################
#Creating Security
resource "aws_security_group" "rdp_sg" {
  name = "RDP"
  description = "Allow RDP inbound traffic"
  vpc_id      = "vpc-01266b519bf4c8813"
  ingress {
      from_port = 3389
      to_port = 3389
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
output "RDP_Sg_id" {
    value = aws_security_group.rdp_sg.id
}
#~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
