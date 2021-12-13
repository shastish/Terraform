#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT2VMCRPIK"
  secret_key = "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"
}
#########################################################
//Create EBS Volume
resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-west-1b"
  count          = "1"
  encrypted = false
  type   = "st1"
  size = 10
  tags = {
    Name = "Windows"
  }
}
output "ebs" {
    value = aws_ebs_volume.ebs.id
  
}
#########################################################
//Attach EBS Volume to Instance
resource "aws_volume_attachment" "ebs_att"{
 device_name="/dev/sdd"
 volume_id= "${aws_ebs_volume.ebs.id}"
 instance_id= var.instanceid
 force_detach=true
}
