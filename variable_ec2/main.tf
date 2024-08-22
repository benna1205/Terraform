provider "aws" {

region = "ap-south-1" #AWS provider

}
resource "aws_instance" "windows" {
  ami                    = var.type
  instance_type          = "t2.micro"
  availability_zone	 = "ap-south-1a"
  key_name		 = "apsouth"
tags = {
 Name = "windows"
}
}

resource "aws_instance" "ubuntu" {
  ami                    = var.type1
  instance_type          = "t2.micro"
  availability_zone      = "ap-south-1a"
  key_name		 = "apsouth"
  user_data		 = file("/home/ubuntu/mark2/ubuntu.sh")
tags = {
 Name = "ubuntu"
}
}

resource "aws_instance" "amazon" {
  ami                    = var.type2
  instance_type          = "t2.micro"
  availability_zone      = "ap-south-1a"
  key_name		 = "apsouth"
  user_data		 = file("/home/ubuntu/mark2/amazon.sh")
tags = {
 Name = "amazon"
}
}
