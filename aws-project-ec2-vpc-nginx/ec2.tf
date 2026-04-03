
# Ec2 instance for Nginx setup

resource "aws_instance" "nginx-server" {
  ami = "ami-0bfa6d0ea0fe2c5a1"
  instance_type = "t3.micro"
  
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
      #!/bin/bash
      sudo yum install nginx -y
      sudo systemctl start nginx
       EOF
  tags = {
    Name="Nginx-Server"
  }
}