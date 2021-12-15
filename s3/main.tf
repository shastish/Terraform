#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT3O737FHG"
  secret_key = "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"
}
#######################################################
#Creating S3 Bucket
resource "aws_s3_bucket" "bucket" {
 bucket = "bucket.uniquename.us.west"
 acl ="public-read" 
 force_destroy = "true"
 versioning{
  enabled = true 
 }
 logging {
    target_bucket = aws_s3_bucket.bucket.uniquename.us.west.id
    target_prefix = "/"
 }
 tags = {
  Name = "bucket"
 }
}
