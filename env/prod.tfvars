aws_region = "us-east-1"

github_settings = {
  repository = "mack-cloud-iaac"
  ssh_secret_name = "AWS_PUBLIC_SSH_KEY"
}

ec2_settings = {
  ami = "ami-04e5276ebb8451442"
  instance_type = "t2.micro"
}

s3_settings = {
  bucket_name = "goncalvesej-tf-state"
  key = "websrv"
}

ssh_settings = {
  public_key_name = "webSrvKey"
  username = "ec2-user"
}