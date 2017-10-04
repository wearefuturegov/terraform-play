#!/bin/bash
yum update -y
yum install -y httpd
# MYIP="ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2"
# echo "'this is: '$MYIP > /var/www/html/index.html"

