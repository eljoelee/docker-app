#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
cd /home/ubuntu
sudo apt update && sudo apt upgrade
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo pip3 install pyopenssl --upgrade
sudo pip3 install docker-compose
sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin