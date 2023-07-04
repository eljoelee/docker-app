
module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.0"

  ami                         = "ami-04341a215040f91bb"
  name                        = "bastion"
  instance_type               = "t2.micro"
  key_name                    = "terraform_ec2_key"
  vpc_security_group_ids      = ["${module.bastion_sg.security_group_id}"]
  subnet_id                   = element(module.vpc.public_subnets, 0)
  associate_public_ip_address = true

  user_data = file("init_bastion.sh")
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("terraform_ec2_key.pub")
}

resource "null_resource" "upload_file" {
  provisioner "file" {
    source      = "terraform_ec2_key.pem"
    destination = "/home/ubuntu/terraform_ec2_key.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terraform_ec2_key.pem")
      host        = module.bastion.public_ip
    }
  }
}