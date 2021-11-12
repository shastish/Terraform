#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT2VMCRPIK"
  secret_key = "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"
}
#########################################################3
# Create the Security Group
resource "aws_security_group" "webserver" {
  vpc_id       = var.vpcid
  name         = "My VPC Security Group"
  description  = "My VPC Security Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
   Name = "RDP"
   Description = "Allow RPD"
    }
}
output "security_group_id" {
  value = aws_security_group.webserver.id
}
#######################################################
#Creating the baction host
resource "aws_instance" "bastion" {
   ami = "ami-0cf4a2d03d1a3d62c"
   instance_type = "t2.micro"
   subnet_id = "${var.subnetCIDRblock}"
   associate_public_ip_address = "true"
   vpc_security_group_ids = [aws_security_group.webserver.id]
   key_name = "cal_key"
    tags = {
      Name = "Bastion"
    }  
}
output "instance_id"{
    value = aws_instance.bastion.id
}
output "Instance_PublicIP" {
    value = aws_instance.bastion.public_ip
}
####################################################################
