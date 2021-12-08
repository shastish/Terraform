#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAUYEPIAMT74ECYOKD"
  secret_key = "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"
}
##########################################################
resource "aws_vpc" "Testing" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_vpc" "Development" {
  cidr_block = "10.0.0.0/16"
}
#Creating VPC Peering between Testing and Development
resource "aws_vpc_peering_connection" "peering" {
  vpc_id      = "vpc-01cb084f40ed1e547" //Testing VPC ID
  peer_vpc_id = "vpc-0ba27102c0570d4dd" //Development VPC ID
  auto_accept = true
  tags ={
      Name = "VPC Peerign between Testing and Developmenet"
  }
}
#Declaring VPC Perrign options
resource "aws_vpc_peering_connection_options" "peeting" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_vpc_to_remote_classic_link = true
  }
}
