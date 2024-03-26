# AWS

aws_settings = {
    region = "us-east-1"
    profile = "default"
}

# EC2

ec2_settings = {
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
}

# SSH

ssh_settings = {
    path = "../ssh-keys/aws.pub"
    name = "srvKey"
}