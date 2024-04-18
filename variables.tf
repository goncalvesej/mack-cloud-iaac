# AWS

variable "aws_region" {
  type = string
}

# Github

variable "github_settings" {
  type = object({
    repository = string
    ssh_secret_name = string
  })
}

# EC2

variable "ec2_settings" {
  type = object({
    ami = string
    instance_type = string
  })
}

# S3

variable "s3_settings" {
  type = object({
    bucket_name = string
    key = string
  })
}

# SSH

variable "ssh_key_name" {
  type = string
}

variable "ssh_public_key" {
  type = string
}