# resource "null_resource" "web-upload" {
#   #需要等待web的ec2创建完成
#   depends_on = [ module.module.ec2-web ]

#   #ssh连接到web服务器
#   connection {
#     type = "ssh"
#     host = module.ec2-web[0].public_ip
#     user = "ec2-user"
#     password = ""
#     private_key = file("keypair/aws-cli-keypair-1.pem")
#   }
#   #建立web目录
#   provisioner "remote-exec" {
#     inline = [ 
#         "sudo mkdir -p /var/www/html",
#         "sudo chown -R ec2-user:ec2-user /var/www/html",
#      ]
#   }
#   #上传本地文件
#   provisioner "file" {
#     source = "web/"
#     destination = "/var/www/html"
#   }
# }