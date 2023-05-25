module "web_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"
  name    = "web_server_sg"
  #设置所属VPC
  vpc_id = module.vpc.vpc_id

  #入口规则
  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  #出口规则
  egress_rules = ["all-all"]

  tags = {
    "Name" = "${local.appName}-web-server-sg"
  }
}
#appserver安全组
module "ap_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"
  name    = "ap-server-sg"

  vpc_id = module.vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.web_server_sg.security_group_id
    }
  ]
  egress_rules = ["all-all"]

  tags = {
    "Name" = "${local.appName}-ap-server-sg"
  }

}
#rds安全组
module "rds_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"
  name    = "rds-server-sg"

  vpc_id = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.ap_server_sg.security_group_id
    }
  ]

  egress_rules = ["all-all"]

  tags = {
    "Name" = "${local.appName}-rds-server-sg"
  }
}
module "ssh_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"
  name = "public-subnets-ssh-sg"

  vpc_id = module.vpc.vpc_id

  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]

  tags = {
    "Name" = "${local.appName}-public-subnets-ssh-sg"
  }
}
module "alb_web_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"
  name = "alb-web-sg"

  vpc_id = module.vpc.vpc_id
  
  ingress_rules = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]

  tags = {
    "Name" : "${local.appName}-alb-web-sg"
  }
}