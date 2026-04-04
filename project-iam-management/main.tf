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
  users_data=yamldecode(file("./users.yaml")).users


    # Approach 1
#   users_role_pair=[for user in local.users_data:[for role in user.roles:{
#     username=user.username
#     role=role
#   }]]

#  Approach 2 using simple approach of flatten
users_role_pair=flatten([for user in local.users_data:[for role in user.roles:{
    username=user.username
    role=role
  }]])
}

output "output" {
  value = local.users_role_pair
}


# Creating users
resource "aws_iam_user" "users" {
    for_each = toset(local.users_data[*].username)
  name = each.value
}


# Password Creation
resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.users
  user=each.value.name
  password_length = 12
  lifecycle {
    ignore_changes = [ 
        password_length,
        password_reset_required,
        pgp_key
     ]
  }
}


# Attaching Policies
 resource "aws_iam_user_policy_attachment" "main" {
   for_each = {
    for pair in local.users_role_pair :
    "${pair.username}-${pair.role}" => pair
  }

  user       = aws_iam_user.users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
 }