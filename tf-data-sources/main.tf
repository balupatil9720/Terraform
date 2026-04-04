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


#  dynamically fetching the name  of the AWS ami
data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}


output "aws_ami" {
 value= data.aws_ami.name.id 
}



# dynamically now security group
data "aws_security_group" "name" {
  tags = {
   mywebserver="http"
  }
}

output "security-group" {
  value = data.aws_security_group.name.id
}


# Vpc
data "aws_vpc" "name" {
  tags = {
    ENV="PROD"
    Name="my-vpc"
  }
}

output "vpc" {
  value = data.aws_vpc.name.id
}


# Availability zones
data "aws_availability_zones" "names" {
  state = "available"
}

output "az" {
 value=data.aws_availability_zones.names
}


# To get the account details
data "aws_caller_identity" "name" {
  
}

output "caller-info" {
  value = data.aws_caller_identity.name
}

# Region name
data "aws_region" "name" {
  
}

output "region-name" {
  value = data.aws_region.name
}

# Subnet id
data "aws_subnet" "name" {
  filter {
    name = "vpc-id"
    values=[data.aws_vpc.name.id]
  }
  tags = {
    Name="private-subnet"
  }
}
resource "aws_instance" "myserver" {
  ami = data.aws_ami.name.id
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]

  tags = {
    Name="SampleServer"
  }
}
