#!/bin/bash
sudo apt update
sudo apt install apache2
sudo apt update
sudo systemctl enable apache2
sudo systemctl start apache2
