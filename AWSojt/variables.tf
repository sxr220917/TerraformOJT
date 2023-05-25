# AWS Region
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-1"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "instance_ami_id" {
  description = "AWS ami id"
  type = string
  default = "ami-0e0820ad173f20fbb"
}
variable "instance_keypair" {
  type = string
  default = "aws-cli-keypair-1"
}