terraform {
  backend "s3" {
    bucket = "bucket name"
    key    = "path/to/my/key/terraform.int"
    region = "ap-south-1"
  }
}
