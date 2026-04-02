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
  }
  backend "s3" {
    bucket = "demo-bucket-49457f88fc730ed6"
    key = "backend.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "myserver" {
  ami = "ami-0bfa6d0ea0fe2c5a1"
  instance_type = "t3.micro"

  tags = {
    Name="SampleServer"
  }
}