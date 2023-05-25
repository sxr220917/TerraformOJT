#!/bin/bash
yum update -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp/awscliv2/
/tmp/awscliv2/aws/install