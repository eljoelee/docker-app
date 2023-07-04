module "server_one" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.0"

  ami                    = "ami-04341a215040f91bb"
  name                   = "server-one"
  instance_type          = "t2.micro"
  key_name               = "terraform_ec2_key"
  vpc_security_group_ids = ["${module.server_sg.security_group_id}"]
  subnet_id              = element(module.vpc.private_subnets, 0)

  user_data = file("init_server.sh")
}

module "server_two" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.0"

  ami                    = "ami-04341a215040f91bb"
  name                   = "server-two"
  instance_type          = "t2.micro"
  key_name               = "terraform_ec2_key"
  vpc_security_group_ids = ["${module.server_sg.security_group_id}"]
  subnet_id              = element(module.vpc.private_subnets, 1)

  user_data = file("init_server.sh")
}
