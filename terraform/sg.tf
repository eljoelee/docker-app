module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name            = "bastion-sg"
  description     = "Security group for bastion"
  vpc_id          = module.vpc.vpc_id
  use_name_prefix = "false"

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "112.170.59.20/32"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name            = "alb-sg"
  description     = "Security group for server alb"
  vpc_id          = module.vpc.vpc_id
  use_name_prefix = "false"

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "server"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name            = "server-sg"
  description     = "Security group for server"
  vpc_id          = module.vpc.vpc_id
  use_name_prefix = "false"

  ingress_with_source_security_group_id = [
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "ssh"
      source_security_group_id = module.bastion_sg.security_group_id
    },
    {
      from_port                = 3000
      to_port                  = 3000
      protocol                 = "tcp"
      description              = "server"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}