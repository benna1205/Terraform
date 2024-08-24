provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "name" {
  instance_type = var.instance
  ami = var.ami
  subnet_id = var.subid
}
