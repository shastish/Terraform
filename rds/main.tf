#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAUYEPIAMT74ECYOKD"
  secret_key = "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"
}
##########################################################
module "rds" {
  source      = "./rds"
  #db_instance = "db.t2.micro"
  #rds_subnet1 = "subnet-0d36e2815d492b8d5" //Prodcution-Private-AZ1a
  #rds_subnet2 = "subnet-024e3fc9323fe9df0"//Prodcution-Private-AZ1b
  #vpc_id      = "vpc-0ba27102c0570d4dd"
}
