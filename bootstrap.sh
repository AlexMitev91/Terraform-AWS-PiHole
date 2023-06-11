#!/bin/bash

#Update packages and hostname
sudo apt update -y
sudo apt upgrade -y
sudo hostnamectl set-hostname pi-hole-serve

#Install common packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common git

#Add Google nameservers and disable systemd-resolver
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
sudo systemctl stop systemd-resolved.service
sudo systemctl disable systemd-resolved.service

#Install docker 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose -y

# Download the compose file and start the container
git clone https://github.com/AlexMitev91/Terraform-AWS-PiHole.git
docker compose -f ~/Terraform-AWS-PiHole/docker-compose.yml up -d