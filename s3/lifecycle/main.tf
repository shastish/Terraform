#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAUYEPIAMT74ECYOKD"
  secret_key = "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"
}
#######################################################
resource "aws_s3_bucket" "bucket" {
  bucket = "amazonmumbaitestbucketumesh" //S3 bucket will be created
  acl    = "private"

  lifecycle_rule {
    id      = "Ansible" //new folder will created and rule will be applied
    enabled = true
    prefix = "Ansible/"
    tags = {
      rule      = "Ansible"
      autoclean = "true"
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    expiration {
      days = 90
    }
  }
  lifecycle_rule {
    id      = "Exam" //new folder will created and rule will be applied
    prefix  = "Exam/" 
    enabled = true
    expiration {
      date = "2025-01-12"
    }
  }
}
resource "aws_s3_bucket" "versioning_bucket" {
  bucket = "amazonmumbaitestbucketumesh" //S3 bucket will be created
  acl    = "private"
  versioning {
    enabled = true
  }
  lifecycle_rule {
    prefix  = "Jenkins/"
    enabled = true
    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }
    noncurrent_version_expiration {
      days = 90
    }
  }
}
