#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT3O737FHG"
  secret_key = "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"
}
#######################################################
#Creating Webserver
resource "aws_instance" "webserver" {
 ami = "ami-053ac55bdcfe96e85"
 instance_type = "t2.micro"
 key_name = var.keyname
 vpc_security_group_ids = [var.linux_security_group]
 subnet_id = var.publicsubnetid
 associate_public_ip_address = "true"
 
 tags = {
  Name = "Webserver"
 }
}
output "Webserver_IP" {
  value = aws_instance.webserver.public_ip
}
output "Webserver_instance_id" {
  value = aws_instance.webserver.id
}
#######################################################
#Creating Application
resource "aws_instance" "application" {
 ami = "ami-0cf4a2d03d1a3d62c"
 instance_type = "t2.micro"
 key_name = var.keyname
 vpc_security_group_ids = [var.windows_security_group]
 subnet_id = var.privatesubnetid
 
 tags = {
  Name = "application"
 }
}
output "Application_IP" {
  value = aws_instance.application.public_ip
}
output "Application_instance_id" {
  value = aws_instance.application.id
}
#######################################################
#Creating db
resource "aws_instance" "db" {
 ami = "ami-00694521ba320ed02"
 instance_type = "t3.xlarge"
 key_name = var.keyname
 vpc_security_group_ids = [var.windows_security_group]
 subnet_id = var.privatesubnetid
 
 tags = {
  Name = "db"
 }
}
output "db_IP" {
  value = aws_instance.db
}
output "db_instance_id" {
  value = aws_instance.db.id
}
########################################################
