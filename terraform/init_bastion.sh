#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
cd /home/ubuntu
git clone https://github.com/eljoelee/docker-app.git
sudo apt update && sudo apt upgrade 
sudo DEBIAN_FRONTEND=noninteractive apt install -yq software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo DEBIAN_FRONTEND=noninteractive apt install -yq ansible
ansible-galaxy collection install community.docker