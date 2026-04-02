variable "region" {
  description = "The aws region to create resources in"
  type = string
  default = "eu-north-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
    
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "random_id" "rand_id" {
  byte_length = 8
}
resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-${random_id.rand_id.hex}"
}


resource "aws_s3_object" "bucket_data" {
    bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./myfile.txt"
  key = "mydata.txt"
}

output "randdom_id_check" {
  value = random_id.rand_id.b64_url
}