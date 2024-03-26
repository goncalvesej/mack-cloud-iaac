terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = var.aws_settings.profile
  region  = var.aws_settings.region
}

resource "aws_instance" "app_server" {
  ami           = var.ec2_settings.ami
  instance_type = var.ec2_settings.instance_type
  key_name = var.ssh_settings.name

  vpc_security_group_ids = [
    "sg_srv01"
  ] 
}

resource "aws_key_pair" "srv01SSHKey" {
    key_name = var.ssh_settings.name
    public_key = file(var.ssh_settings.path)
}

resource "aws_security_group" "sg_srv01" {
  name = "sg_srv01"
  description = "Web server security group"
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
  tags = {
    Name = "sg_srv01"
  }
}

output "srv01_public_ip" {
  value = aws_instance.app_server.public_ip
}