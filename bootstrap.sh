#!/bin/bash

#Update packages and hostname
sudo apt update -y
sudo apt upgrade -y
sudo hostnamectl set-hostname pi-hole-server

#Install common packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common git -y

#Add Google nameservers and disable systemd-resolver
sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
sudo systemctl stop systemd-resolved.service
sudo systemctl disable systemd-resolved.service

#Install docker 
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker

# Download the compose file and start the container
sudo git clone https://github.com/AlexMitev91/Terraform-AWS-PiHole.git /tmp/pi-hole
sudo docker compose -f /tmp/pi-hole/docker-compose.yml up -d