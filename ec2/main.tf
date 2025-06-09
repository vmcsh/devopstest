################################################################################
# Key Pair
################################################################################

resource "aws_key_pair" "this" {
  key_name   = "test-key"                             # Name of the key pair in AWS
  #public_key = file("C:/Users/YourName/.ssh/id_rsa.pub") 
  public_key = file("C:\\Users\\Shravani\\.ssh\\id_rsa.pub")  # Ensure this file exists
}

################################################################################
# Instance
################################################################################

resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  availability_zone           = var.availability_zone
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  key_name                    = aws_key_pair.this.key_name  # Use key created above
  iam_instance_profile        = var.iam_instance_profile_arm

  associate_public_ip_address = var.associate_public_ip_address

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    tags        = var.root_block_device_tags
  }

  tags = merge(var.tags, {
    Name = "ec2-instance"
  })
}

################################################################################
# Elastic IP
################################################################################

resource "aws_eip" "this" {
  instance = aws_instance.this.id
  domain   = var.eip_domain
  tags     = merge(var.tags, var.eip_tags)
}

################################################################################
# Security Group
################################################################################

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
