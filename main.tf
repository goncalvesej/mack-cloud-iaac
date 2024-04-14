# Setup

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }

    ansible = {
      version = "~> 1.2.0"
      source  = "ansible/ansible"
    }
  }

  backend "s3" {
    bucket = var.s3_settings.bucket_name
    key    = var.s3_settings.key
    region = var.aws_region
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = var.aws_region
}

# SSH

resource "github_actions_secret" "srvSSHKey" {
  repository       = var.github_settings.repository
  secret_name      = var.github_settings.secret_name
}

resource "aws_key_pair" "srvSSHKey" {
    key_name = var.ssh_settings.name
    public_key = srvSSHKey
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
  key_name = var.ssh_settings.name

  vpc_security_group_ids = [
    aws_security_group.sg_web_srv.id
  ] 
}

# Ansible

# resource "local_file" "inventory" {
#   content = templatefile("./inventory.tftpl", { host_ssh_user = var.ssh_settings.user, host_ip_addr = aws_instance.app_server.public_ip })
#   filename = "${path.module}/hosts.yml"
# }

# resource "ansible_playbook" "playbook" {
#   playbook   = "aws.yml"
#   name       = "host"
#   replayable = true

#   extra_vars = {
#     inventory = "{'webservers': ['${aws_instance.app_server.public_ip}']}"
#     private-key = file(var.ssh_settings.path)
#   }
# }