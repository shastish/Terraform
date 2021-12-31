#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAWQ6CF88888PKV7RGPRBUD"
  secret_key = "ci8iHF1CY9bBgFh697890kQvbHjS7ngscugTTf5hxYOFRe"
}
#######################################################
#Creating Production VPC with CIDR: 10.0.0.0/16
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16" 
    tags = {
        Name = "test VPC"
    }
}
output "vpcid" {
  value = aws_vpc.vpc.id
}
#######################################################
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
#Adding Route table and IGW
resource "aws_route_table" "prod_public_rt" {
    vpc_id = "${aws_vpc.vpc.id}"  
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"         //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.prod_igw.id}" 
    }
    tags = {
        Name = "prod-public-rt"
    }
}
output "Prodution_Public_RT_id" {
  value = aws_route_table.prod_public_rt.id
}
#######################################################
#Adding public subnet to public route table
resource "aws_route_table_association" "prod-public-routetable"{
    subnet_id = "${aws_subnet.production_public_subnet.id}"
    route_table_id = "${aws_route_table.prod_public_rt.id}"
}
#######################################################
#Creating an EIP
resource "aws_eip" "production_nat_eip" {
  vpc = true
  tags = {
      Name = "production_nat_eip"
  }
}
output "production_nat_eip" {
  value = aws_eip.production_nat_eip.id
}
###################################################################
#Creating NatGateway for Production VPC
resource "aws_nat_gateway" "production_natgateway"{
   allocation_id= "${aws_eip.production_nat_eip.id}"
   subnet_id = "${aws_subnet.production_public_subnet.id}"
    tags = {
      Name = "Production Natgateway"
          }
}
output "production_natgateway_id" {
  value = aws_nat_gateway.production_natgateway.id
}
#######################################################################
#Adding Route table and NatGateway
resource "aws_route_table" "prod_private_rt" {
    vpc_id = "${aws_vpc.vpc.id}"  
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"         //CRT uses this IGW to reach internet
        gateway_id = "${aws_nat_gateway.production_natgateway.id}" 
    }
    tags = {
        Name = "prod-private-rt"
    }
}
output "Prodution_Private_RT_id" {
  value = aws_route_table.prod_private_rt.id
}
#######################################################
#Adding private subnet to private route table
resource "aws_route_table_association" "prod-private-routetable"{
    subnet_id = "${aws_subnet.prodution_private_subnet.id}"
    route_table_id = "${aws_route_table.prod_private_rt.id}"
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~#
