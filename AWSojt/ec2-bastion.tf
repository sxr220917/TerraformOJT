# module "ec2-bastion" {
#   depends_on = [module.vpc]
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "5.0.0"

#   name = "${local.appName}-bastion"
#   ami = var.instance_ami_id
#   instance_type = var.instance_type
#   key_name = var.instance_keypair

#   subnet_id = module.vpc.public_subnets[0]

#   user_data = file("${path.module}/ec2-bastion-userdata.sh")

#   vpc_security_group_ids = [module.ssh_server_sg.security_group_id]
#   tags = {
#     "Name" = "${local.appName}-bastion"
#   }
# }