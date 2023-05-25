#使用VPC模块建立VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "ojt-vpc"
  #ip
  cidr = "172.16.0.0/24"
  #启用dns
  enable_dns_hostnames = true
  #启用dns支持
  enable_dns_support = true
  #配置使用的az
  azs = ["ap-northeast-1a", "ap-northeast-1c"]
  #配置公有网段（会自动在路由表中配置IGW）
  public_subnets = ["172.16.0.16/28", "172.16.0.0/28"]
  #配置私有网段
  private_subnets = ["172.16.0.144/28", "172.16.0.128/28"]

  public_subnet_tags = {
    Name = "${local.appName}-public-subnets"
  }
  private_subnet_tags = {
    Name = "${local.appName}-private-subnets"
  }

  vpc_tags = {

    "Name"    = "${local.appName}-vpc"
    terraform = true

  }

  #NAT设置，每个私有子网有一个NAT网关
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false

}
