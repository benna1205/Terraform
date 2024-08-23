#!/bin/bash
sudo yum update
sudo yum install apache2
sudo yum update
sudo systemctl enable apache2
sudo systemctl start apache2
