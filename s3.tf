terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
  access_key = "AKIAX3LNWYOGIVRPHOXY"
  secret_key = "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"
}


resource "aws_s3_bucket" "b" {
 bucket = "parallel-research-s3-bucket"
}

resource "aws_s3_bucket_public_access_block" "b" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "b" {
 bucket = aws_s3_bucket.b.id
 policy = <<POLICY
{
 "Version": "2012-10-17",
 "Id": "MYBUCKETPOLICY",
 "Statement": [
   {
      "Sid": "GrantAnonymousReadPermissions",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::parallel-research-s3-bucket/*"
   },
  {
    "Sid": "GrantAnonymousReadPermissions1",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::parallel-research-s3-bucket/*"
  }
]
}
POLICY
depends_on = [ aws_s3_bucket_public_access_block.b ]
}