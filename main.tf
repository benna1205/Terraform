#aws provider
provider "aws" {
  region = "ap-south-1"
}
#Creating ubuntu instance and installing nginx
resource "aws_instance" "linux1" {
    instance_type = "t2.micro"
    ami =  var.instance1
    availability_zone = "ap-south-1a"
    key_name = "apsouth"
    user_data = file("/home/ubuntu/ec2_var/nginx_linux.sh")
tags = {
Name = "nginx"
}
}
#Creating ubunt_instance and installing apache
resource "aws_instance" "linux2" {
    instance_type = "t2.micro"
    ami =  var.instance1
    availability_zone = "ap-south-1a"
    key_name = "apsouth"
    user_data = file("/home/ubuntu/ec2_var/apache_linux.sh")
tags = {
Name = "apache2"
}
}
#Creating amazon instane and installing nginx
resource "aws_instance" "amzon1" {
    instance_type = "t2.micro"
    ami =  var.instance2
    availability_zone = "ap-south-1a"
    key_name = "apsouth"
    user_data = file("/home/ubuntu/ec2_var/nginx_amazon.sh")
tags = {
Name = "nginx_am"
}
}
#Creating amazon instance and intalling apache
resource "aws_instance" "amzon2" {
    instance_type = "t2.micro"
    ami =  var.instance2
    availability_zone = "ap-south-1a"
    key_name = "apsouth"
    user_data = file("/home/ubuntu/ec2_var/apache_amazon.sh")
tags = {
Name = "amazon_am"
}
}
