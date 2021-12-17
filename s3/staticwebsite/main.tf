#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAWQ6CFPKVYENJ26DL"
  secret_key = "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"
}
#######################################################
#to create a bucket and enable static website
resource "aws_s3_bucket" "bucket" {
  bucket = "umeshumeshumeshumesh"
  acl    = "public-read"                        #this gives public readonly premission 
  force_destroy = "true"                        #will delete the bucket evn if it has object in it
  website {                                     #this block define/enable the static website 
    index_document = "index.html"
  }
}
##########################################################
//this block is useed to upload a file in s3 bukcet
resource "aws_s3_bucket_object" "object" {

  bucket = aws_s3_bucket.bucket.id
  key = "Welcome"
  provisioner "local-exec" {
     command = "aws s3 cp F:/welcome.html s3://${aws_s3_bucket.bucket.id}" //To run this command aws cli should be install on the source machine
  }
  //syntax aws s3 cp sourcepath destinatiopath<s3://bucket name>
}
