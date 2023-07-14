module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  name = "server-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = [element(module.vpc.public_subnets, 0), element(module.vpc.public_subnets, 1)]
  security_groups = [module.alb_sg.security_group_id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 3000
      target_type      = "instance"

      targets = {
        server_one = {
          target_id = module.server_one.id
          port      = 3000
        }
        server_two = {
          target_id = module.server_two.id
          port      = 3000
        }
      }
    }
  ]
}