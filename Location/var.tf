variable "instance" {
  description = "instance ami ID "
  #type = string
  #default = "ami-0522ab6e1ddcc7055"
}
variable "vpc" {
  #description = "vpc cidr block"
  #type = string
  #default = "10.0.0.0/16"
}
variable "instancetype" {
  description = "type of the instance"
  #type = string
  #default = "t2.micro"
}
variable "key" {
description = "key to log in to server"
#type = string
#default = "apsouth"
}