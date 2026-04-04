
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "myserver" {
  ami = "ami-0bfa6d0ea0fe2c5a1"
  instance_type = "t3.micro"
   
   root_block_device {
     delete_on_termination = true
     volume_size = 32
     volume_type = "gp2"
   }
  tags = {
    Name="SampleServer"
  }
}