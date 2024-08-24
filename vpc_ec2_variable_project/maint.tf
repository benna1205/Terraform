provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "vpc-project" {
  cidr_block = var.vpc
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
 resource "aws_instance" "Instance1" {
    instance_type = var.instancetype
    ami = var.instance
    key_name = var.key
    subnet_id = aws_subnet.subnet1.id
    #security_groups = [aws_security_group.vpc_sg.name]
      tags = {
      Name = "server1"
     }
     user_data = file("/workspaces/Terraform/vpc_Ec2_varible_project1/instance1.sh")  
     }
    resource "aws_instance" "Instance2" {
    instance_type = var.instancetype
    ami = var.instance
    key_name = var.key
    subnet_id = aws_subnet.subnet2.id
    #security_groups = [aws_security_group.vpc_sg.name]
    tags = {
      Name = "server2"
     }
     user_data = file("/workspaces/Terraform/vpc_Ec2_varible_project1/instance2.sh")
  }
  resource "aws_instance" "Instance3" {
    instance_type = var.instancetype
    ami = var.instance
    key_name = var.key
    subnet_id = aws_subnet.subnet2.id
    #security_groups = [aws_security_group.vpc_sg.name]
    tags = {
      Name = "server3"
     }
     user_data = file("/workspaces/Terraform/vpc_Ec2_varible_project1/instance3.sh")
  }
  output "instance_publicip" {
    value = aws_instance.Instance1.public_ip
  }
  output "instance_publicip2" {
    value = aws_instance.Instance2.public_ip
  }
  output "instance_publicip3" {
    value = aws_instance.Instance3.public_ip
  }