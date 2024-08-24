provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "vpc-project" {
  cidr_block = "10.0.0.0/16"
tags = {
  Name = "vpc1"
}
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-project.id
  tags = {
    Name = "IG"
  }
}
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc-project.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc-project.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  }
  resource "aws_route_table" "vpc_route" {
    vpc_id = aws_vpc.vpc-project.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  }
  resource "aws_route_table_association" "vpc_route_table" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.vpc_route.id
  }
  resource "aws_route_table_association" "vpc_route_table2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.vpc_route.id
  }
  resource "aws_security_group" "vpc_sg" {
  name   = "allow_http_ssh"
  vpc_id = aws_vpc.vpc-project.id

  # Ingress rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}
 resource "aws_instance" "instance1" {
    instance_type = "t2.micro"
    ami = "ami-0522ab6e1ddcc7055"
    subnet_id = aws_subnet.subnet1.id
    #security_groups = [aws_security_group.vpc_sg.name]
      tags = {
      Name = "Nginx"
     }
     user_data = <<-EOF
     #!/bin/bash
     sudo apt update
     sudo apt install nginx -y
     echo "<html><body><h1>Welcome to Server 1 </h1></body></html>" > /var/www/html/index.html
     sudo systemctl enable nginx
     sudo systemctl start nginx
     EOF
  }
  resource "aws_instance" "Instance2" {
    instance_type = "t2.micro"
    ami = "ami-0522ab6e1ddcc7055"
    subnet_id = aws_subnet.subnet2.id
    #security_groups = [aws_security_group.vpc_sg.name]
    tags = {
      Name = "Nginx2"
     }
     user_data = <<-EOF
     #!/bin/bash
     sudo apt update
     sudo apt install nginx -y
     echo "<html><body><h1>Welcome to Server 2 </h1></body></html>" > /var/www/html/index.html
     sudo systemctl enable nginx
     sudo systemctl start nginx
     EOF
  }
  output "instance_publicip" {
    value = aws_instance.instance1.public_ip
  }
  output "instance_publicip2" {
    value = aws_instance.Instance2.public_ip
  }