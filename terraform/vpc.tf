module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "test-vpc"
  cidr = "10.1.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2c"]
  private_subnets = ["10.1.10.0/24", "10.1.20.0/24"]
  public_subnets  = ["10.1.30.0/24", "10.1.40.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
}