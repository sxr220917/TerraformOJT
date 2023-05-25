module "alb-web" {
  depends_on = [module.vpc]

  source  = "terraform-aws-modules/alb/aws"
  version = "8.6.0"

  name               = "${local.appName}-alb-web"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.alb_web_sg.security_group_id]

  target_groups = [
    {
      name_prefix      = "web-"
      backend_protocol = "HTTP"
      backend_prot     = 80
      target_type      = "instance"

      targets = {
        webserver1 = {
          target_id = module.ec2-web[0].id
          port      = 80
        },
        webserver2 = {
          target_id = module.ec2-web[1].id
          port      = 80
        }
      }
      tags = {
        "Name" = "${local.appName}-alb-target-group"
      }
    }
  ]
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  
  tags = {
    "Name" = "${local.appName}-alb"
  }
}
