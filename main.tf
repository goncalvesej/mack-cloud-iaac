# Setup

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket = "goncalvesej-tf-state"
    key    = "websrv"
    region = "us-east-1"
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = var.aws_region
}

# SSH

resource "aws_key_pair" "srvSSHKey" {
    key_name = var.ssh_settings.key_name
    public_key = var.ssh_key
}

# EC2

resource "aws_security_group" "sg_web_srv" {
  name = "sg_web_srv"
  description = "security group for web server"
  ingress{
      cidr_blocks = [ "0.0.0.0/0" ]
      ipv6_cidr_blocks = [ "::/0" ]
      from_port = 0
      to_port = 0
      protocol = "-1"
  }
  egress{
      cidr_blocks = [ "0.0.0.0/0" ]
      ipv6_cidr_blocks = [ "::/0" ]
      from_port = 0
      to_port = 0
      protocol = "-1"
  }
}

resource "aws_instance" "app_server" {
  ami           = var.ec2_settings.ami
  instance_type = var.ec2_settings.instance_type
  key_name = var.ssh_settings.key_name

  vpc_security_group_ids = [
    aws_security_group.sg_web_srv.id
  ] 
}

# resource "local_file" "inventory" {
#   content = templatefile("./inventory.tftpl", { host_ssh_user = var.ssh_settings.username, host_ip_addr = aws_instance.app_server.public_ip })
#   filename = "${path.module}/hosts.yml"
# }

output "webserver_url" {
  value = aws_instance.app_server.public_ip
}