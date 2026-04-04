ec2_config = [ {
  ami="ami-080254318c2d8932f"  #ubuntu
  instance_type = "t3.micro"
},{
    ami="ami-0bfa6d0ea0fe2c5a1"  #amazon linux
    instance_type = "t3.micro"
} ]

ec2_map = {
  "ubuntu" = {
    ami="ami-080254318c2d8932f"  #ubuntu
    instance_type = "t3.micro"
  },
  "amazon-linux"={
    ami="ami-0bfa6d0ea0fe2c5a1"  #amazon linux
    instance_type = "t3.micro"
  }
}