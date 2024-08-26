#!/bin/bash
sudo apt update
sudo apt install apache2 -y
#echo > /var/www/html/index.html
sudo systemctl enable apache2
sudo systemctl start apache2
