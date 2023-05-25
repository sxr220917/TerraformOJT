# #terraform基本设置
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }

# # Configure the AWS Provider
# provider "aws" {
#     profile = "aws-cli"
# }
###########################################################
# Terraform 基本设置
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22"
    }
    #空资源提供器
    null = {
        source = "hashicorp/null"
        version = "3.2.1"
    }
  }

  required_version = ">= 1.2.5"
}

###########################################################
# 提供商设置(云平台)
provider "aws" {
  profile = "default"
  region  = var.aws_region
}
