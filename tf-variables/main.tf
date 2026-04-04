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
}

provider "aws" {
  # Configuration options
  region = var.region
}

# Local variables/ local values
locals {
  qwner="ABC"
  name="Myserver"
}


resource "aws_instance" "myserver" {
  ami = "ami-0bfa6d0ea0fe2c5a1"
  instance_type = var.aws_instance_type
   
   root_block_device {
     delete_on_termination = true
     volume_size = var.ec2_config.v_size
     volume_type = var.ec2_config.v_type
   }
  tags = merge(var.additional_tags,{
    Name=local.name
  })
}