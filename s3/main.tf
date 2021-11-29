#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT3O737FHG"
  secret_key = "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"
}
#######################################################
#Creating S3 Bucket
resource "aws_s3_bucket" "bucket" {
 bucket = "bucket.uniquename.us.west.1"
 acl ="public-read" 
 force_destroy = "true"
 versioning{
  enabled = true 
 }
 tags = {
  Name = "bucket"
 }
}
