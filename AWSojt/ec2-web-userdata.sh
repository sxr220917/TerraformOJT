#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo '<h1>Terraform EC2.</h1>' | sudo tee /var/www/html/index.html