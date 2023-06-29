# EC2 - Bastion
```sh
git clone https://github.com/eljoelee/docker-app.git

sudo apt update && sudo apt upgrade 

sudo apt install software-properties-common

sudo apt-add-repository --yes --update ppa:ansible/ansible

sudo apt install -y ansible

ssh-keygen -t rsa

# 내용 복사
cat ~/.ssh/id_rsa.pub

# ping : ok 확인
ansible docker -i hosts -m ping

ansible-galaxy collection install community.docker

ansible-playbook playbook.yml -i /home/ubuntu/docker-app/ansible/hosts
```
---
# EC2 - Server
```sh
sudo apt update && sudo apt install -y python3-pip

sudo pip install docker-compose

sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 위 베스천 서버에서 복사한 내용 붙여넣기
vi ~/.ssh/authorized_keys
```