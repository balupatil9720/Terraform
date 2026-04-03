output "instance_public_ip" {
  description = "Aws instance public IP"
  value = aws_instance.nginx-server.public_ip
}

output "instance_url" {
  description = "The url to access the Nginx server"
  value = "http://${aws_instance.nginx-server.public_ip}"
}