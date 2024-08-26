provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "testing" {
  instance_type = "t2.micro"
  ami = var.instance
  key_name = "apsouth"
  user_data = file("/workspaces/Terraform/backend_project/backend.sh")
  availability_zone = "ap-south-1a"
tags = {
  Name = "Instance1"
}
}
output "instnace" {
  value = aws_instance.testing.public_ip
  
}