resource "aws_launch_configuration" "ojt_asg_launch" {
  name_prefix     = "ojt-asg-"
  image_id        = var.instance_ami_id
  instance_type   = var.instance_type
  user_data       = file("${path.module}/ec2-web-userdata.sh")
  security_groups = [module.web_server_sg.security_group_id]

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "ojt_asg" {
  name = "${local.appName}-asg"
  min_size = 2
  desired_capacity = 2
  max_size = 4
  launch_configuration = aws_launch_configuration.ojt_asg_launch.name
  vpc_zone_identifier = module.vpc.public_subnets
  tag {
    key = "Name"
    value = "${local.appName}-alb-asg"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.ojt_asg.id
  alb_target_group_arn = tostring(module.alb-web.target_group_arns[0])
}