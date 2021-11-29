#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT3O737FHG"
  secret_key = "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"
}

#Creating Public Subnet with CIDR: 10.0.0.0/24
resource "aws_subnet" "production_public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-west-1b"
  map_public_ip_on_launch = true
  tags = {
    Name        = "production-public-subnet-1b"
  }
}
output "public_subnetid" {
  value = aws_subnet.production_public_subnet.id
}
#######################################################
#Creating Private Subnet with CIDR: 10.0.1.0/24
resource "aws_subnet" "prodution_private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-1b"
  tags = {
    Name        = "production-private-subnet-1b"
  }
}
output "private_subnetid" {
  value = aws_subnet.prodution_private_subnet.id
}
#######################################################
#Creating IGW and attaching for Production VPC 
resource "aws_internet_gateway" "prod_igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags = {
        Name = "prod-igw"
    }
}
output "internet_gateway_id" {
  value = aws_internet_gateway.prod_igw.id
}
#######################################################
