# AWS

# variable "aws_region" {
#   type    = string
# }

# variable "aws_profile" {
#     type = string
# }

variable "aws_settings" {
  type = object({
    profile = string
    region = string
  })
}


# EC2

variable "ec2_settings" {
  type = object({
    ami = string
    instance_type = string
  })
}

// SSH

variable "ssh_settings" {
  type = object({
    path = string
    name = string
  })
}