#!/bin/bash
sudo apt update
sudo apt install nginx
sudo apt update
sudo systemctl enable nginx
sudo systemctl start nginx

