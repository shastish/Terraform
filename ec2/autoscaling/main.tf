#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAUYEPIAMT74ECYOKD"
  secret_key = "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"
}

###############################################################
module "auto_scaling" {
  source           = "./auto_scaling"
  vpc_id           = "vpc-0ba27102c0570d4dd" //change
  subnet1          = "subnet-0c7c1bc41cf0b7e93" //change-AZ1a
  subnet2          = "subnet-0efa44c305c444ca4" //change-AZ1b
}
