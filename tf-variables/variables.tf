# Adding  validation for the variables
variable "aws_instance_type" {
  description = "what type of instance you want to create"
  type = string
  validation {
    condition = var.aws_instance_type=="t2.micro"||var.aws_instance_type=="t3.micro"
    error_message = "only t3 micro or t2 micro allowed"
  }
}

# variable "volume_size" {
#   type = number
#   default = 20
# }

# variable "volume_type" {
#   type = string
#   default = "gp2"
# }

# Combining variables
variable "ec2_config" {
  type = object({
    v_size = number
    v_type = string
  })

  default = {
    v_size = 20
    v_type = "gp2"
  }
}

variable "additional_tags" {
  type = map(string) #expecting key value format
  default = {}
}


