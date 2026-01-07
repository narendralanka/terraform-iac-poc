
data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.al2.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -ex
              yum update -y
              amazon-linux-extras install nginx1 -y || yum install -y nginx
              systemctl enable nginx
              echo "Hello from Terraform on $(hostname)" > /usr/share/nginx/html/index.html
              systemctl start nginx
              EOF

  tags = merge(var.tags, { Name = "${var.project}-${var.environment}-ec2" })
}
