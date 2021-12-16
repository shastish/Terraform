#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAVQG7BNCWRNIX5CPJ"
  secret_key = "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"
}
#######################################################
#Creating S3 Bucket
resource "aws_s3_bucket" "bucket" {
 bucket = "umeshcovaibukcet"
 acl ="private" 
 force_destroy = "true"
 versioning {
    enabled = true
  }
  logging {
    target_bucket = "umeshcovaibukcet"
    target_prefix = "log/"
 }
 tags = {
  Name = "bucket"
 }
}
