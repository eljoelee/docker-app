# 사전 작업
## PuTTY-gen 
1. Generate > Save public key > terraform_ec2_key.pub
2. Save private key > terraform_ec2_key.ppk
3. Load > terraform_ec2_key.ppk > Conversions > Export OpenSSH Key > terraform_ec2_key.pem
4. .pem & .pub > terraform 디렉토리 하위에 복사
---
# EC2 - Bastion
```sh
# 서버 인스턴스 Private IP 삽입
sudo vi /home/ubuntu/docker-app/ansible/hosts

# ssh-key 생성
ssh-keygen -t rsa

# 내용 복사
cat ~/.ssh/id_rsa.pub

# ping : ok 확인
ansible docker -i hosts -m ping

# Playbook 실행
ansible-playbook playbook.yml -i hosts
```
# EC2 - Server
```sh
# 위 베스천 서버에서 복사한 내용 붙여넣기
sudo vi ~/.ssh/authorized_keys
```