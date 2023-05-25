module "ec2-ap" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"
  #基本信息配置
  count = 2
  name = "${local.appName}-apserver-${count.index + 1}"
  ami = var.instance_ami_id
  instance_type = var.instance_type
  key_name = var.instance_keypair

  #动态分配私有子网
  subnet_id = module.vpc.private_subnets[count.index % length(module.vpc.private_subnets)]
  
  #指定安全组
  vpc_security_group_ids = [module.ap_server_sg.security_group_id]

  tags = {
    "Name" = "${local.appName}-apserver-${count.index + 1}"
  }
}