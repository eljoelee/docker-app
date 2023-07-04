# 사전 작업
## PuTTY-gen 
1. Generate > Save public key > terraform_ec2_key.pub
2. Save private key > terraform_ec2_key.ppk
3. Load > terraform_ec2_key.ppk > Conversions > Export OpenSSH Key > terraform_ec2_key.pem
4. .pem & .pub > terraform 디렉토리 하위에 복사
---
# 서버 작업
```sh
# Bastion 접속 후 hosts 파일에 서버 인스턴스 Private IP 삽입
sudo vi /home/ubuntu/docker-app/ansible/hosts

# ssh-key 생성
ssh-keygen -t rsa

# 내용 복사
cat ~/.ssh/id_rsa.pub

# 서버 인스턴스 SSH 접속
sudo ssh -i terraform_ec2_key.pem ubuntu@10.1.xx.x

# 서버 인스턴스 인증키 등록(상기 복사한 내용 붙여넣기)
ubuntu@10.1.xx.x: $sudo vi ~/.ssh/authorized_keys

# ping : ok 확인
ansible docker -i hosts -m ping

# Playbook 실행
ansible-playbook playbook.yml -i hosts
```