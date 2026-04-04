terraform {}

# Learning how to  manage data in terraform
# Number list
variable "num_list" {
  type = list(number)
  default = [ 1,2,3,4,5 ]
}


# Object list of Person
variable "person_list" {
  type = list(object({
    fname = string
    lname=string
  }))

  default = [ {
    fname = "balu"
    lname = "patil"
  } ,{
    fname = "akash"
    lname = "patil"
  }]
}


# map list of numbers
variable "map_list" {
  type = map(number)
  default = {
    "zero" = 0
    "one"=1
    "two"=2
    "three"=3
  }
}


# Calculations
locals {
  mul=2*6
  add=2+2
  eq= 2!=3

#   double the list
 double=[for num in var.num_list:num*2]

#  Odd numbers only
 odd=[for num in var.num_list:num if num%2==1]

#  To get only fnames from  person list
fnames=[for person in var.person_list: person.fname]

# work with map
values=[for key,value in var.map_list:key]

double_map={for key,value in var.map_list:key=>value*4}
}

output "output" {
#  value = local.mul 
#  value=local.eq
# value = var.num_list
# value = local.double
# value = local.odd
# value = local.fnames
# value = local.values
value = local.double_map
}