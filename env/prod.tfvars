aws_region = "us-east-1"

github_settings = {
  repository = "mack-cloud-iaac"
  ssh_secret_name = "AWS_PUBLIC_SSH_KEY"
}

ec2_settings = {
  ami = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
}

s3_settings = {
  bucket_name = "goncalvesej-tf-state"
  key = "websrv"
}

ssh_settings = {
  name = "srvKey"
  user = "ubuntu"
}