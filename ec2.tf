provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

module "ec2_instance" {
  source = "./ec2"  # Adjust path to match your directory structure

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type               = "t3.micro"
  availability_zone           = "ap-south-1c"
  subnet_id                   = "subnet-030a53a5384c43cc2"
  key_name                    = "mahesh-key"
  iam_instance_profile_arm    = "test_role"

  volume_size                 = 8
  volume_type                 = "gp3"
  root_block_device_tags      = {
    Name = "RootVolume"
  }

  user_data                   = file("${path.module}/userdata.sh")
  user_data_replace_on_change = false

  vpc_id                      = "vpc-07ec26c8eb007d8be"
  cidr_blocks                 = ["0.0.0.0/0"]

  eip_domain                  = "vpc"
  eip_tags                    = {
    Name = "MyEC2-EIP"
  }

  tags = {
    Environment = "dev-test"
    Project     = "web-app"
  }
}
