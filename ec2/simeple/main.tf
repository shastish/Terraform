#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQNULLGUS4FXKNGX3"
  secret_key = "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"
}
#######################################################
#Creating the baction host
resource "aws_instance" "bastion" {
   ami = "ami-04505e74c0741db8d"
   instance_type = "t2.micro"
   subnet_id = "subnet-0738d3b15dab467d0"
   associate_public_ip_address = "true"
   vpc_security_group_ids = ["sg-0896a8bd7f4173611"]
   key_name = "ashwinNVkey"
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
