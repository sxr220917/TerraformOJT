module "rds" {
  depends_on = [ module.vpc ]

  source  = "terraform-aws-modules/rds/aws"
  version = "5.9.0"

  #数据库引擎
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.small"

  #数据库标识符，在当前AWS区域中每个账户拥有的所有数据库实例中必须是唯一的
  identifier = "ojt-web-rds-1"

  #初始化数据库设置
  db_name = "ojtdb"
  username = "root"
  password = "sz123456"
  port = 3306

  #硬盘分配
  allocated_storage = 5
  #非加密存储
  storage_encrypted = false
  #数据库子网
  create_db_subnet_group = true
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  #数据库安全组
  vpc_security_group_ids = [module.rds_server_sg.security_group_id]

  tags = {
    "Name" : "${local.appName}-rds"
  }
  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]
  #tags
  db_instance_tags = {
    "Name" : "${local.appName}-db_instance"
  }
  db_option_group_tags = {
    "Name" : "${local.appName}-db_option_group"
  }
  db_parameter_group_tags = {
    "Name" : "${local.appName}-db_parameter_group"
  }
  db_subnet_group_tags = {
    "Name" : "${local.appName}-db_subnet_group"
  }
}