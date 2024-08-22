#!/bind/bash
sudo yum update
sudo yum install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
