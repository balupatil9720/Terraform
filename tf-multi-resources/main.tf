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

locals {
  project="project-01"
}

# Task 1
# Creating multiple subnets dynamically using count
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="${local.project}-vpc"
  }
}


resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name="${local.project}-subnet-${count.index}"
  }
}

output "subnet_id" {
  value = aws_subnet.main[0].id
}


# Task 2
# Creating 4 EC2 instances two in one subnet and other two in other subnet


# Creating 4 aws instances
# resource "aws_instance" "main" {
#   ami = "ami-0bfa6d0ea0fe2c5a1"
#   instance_type = "t3.micro"
#   count = 4
#   subnet_id = element(aws_subnet.main[*].id,count.index%length(aws_subnet.main))

#   tags = {
#     Name="${local.project}-instance-${count.index}"
#   }
# }


# Task 3 
# Create two subnets  2 ec2 instances 1 in each subnet
#  ec2 1-->ubuntu ec2 2----> amazon linux


# resource "aws_instance" "main" {
#     count =length(var.ec2_config)
#      ami = var.ec2_config[count.index].ami
#      instance_type = var.ec2_config[count.index].instance_type

#     subnet_id = element(aws_subnet.main[*].id,count.index%length(aws_subnet.main))
  
#   tags = {
#     Name="${local.project}-instance-${count.index}"
#   }
# }


# Task 4 above task using FOR_EACH instead of Count

resource "aws_instance" "main" {
    for_each = var.ec2_map
    #  we will get each.key and each.value

     ami = each.value.ami
     instance_type = each.value.instance_type

    subnet_id = element(aws_subnet.main[*].id,index(keys(var.ec2_map),each.key)%length(aws_subnet.main))
  
  tags = {
    Name="${local.project}-instance-${each.key}"
  }
}