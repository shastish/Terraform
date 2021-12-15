#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT74ECYOKD"
  secret_key = "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"
}
#######################################################
#Creating S3 Bucket
resource "aws_s3_bucket" "bucket" {
 bucket = "umeshcovaibukcet"
 acl ="public-read" 
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
