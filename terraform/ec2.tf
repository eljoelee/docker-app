module "server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.0"

  for_each = toset(["one", "two"])
  name = "server-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "eljoe-mydata"
  vpc_security_group_ids = ["${module.server_sg.id}"]
  subnet_id              = "${element(module.vpc.private_subnets, 0)}"
  
  user_data = <<EOF
    #!/bin/bash
    sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt install -yq python3-pip
    sudo pip install docker-compose
    sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  EOF
}