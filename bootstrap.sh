#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

sudo hostnamectl set-hostname pi-hole-serve

sudo apt install apt-transport-https ca-certificates curl software-properties-common

echo "nameserver 8.8.8.8" >> /etc/resolv.conf

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose -y