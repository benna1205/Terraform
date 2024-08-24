provider "aws" {
  region = "ap-south-1"
}
module "ec2" {
  source = "location"
  instance = ""
  vpc = ""
  instancetype = ""
  key = ""
}
  