#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQN******FXKNGX3"
  secret_key = "m8DQiIFf***CaS5vrCJJVQRrn4uZX"
}
#######################################################
#Creating the baction host
resource "aws_instance" "bastion" {
   ami = "ami-04505e74c0741db8d" //change ami id
   instance_type = "t2.micro"
   subnet_id = "subnet-0738d3b15dab467d0" //change subnet id
   associate_public_ip_address = "true"
   vpc_security_group_ids = ["sg-0896a8bd7f4173611"] //change sg id
   key_name = "ashwinNVkey" //change key name
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
