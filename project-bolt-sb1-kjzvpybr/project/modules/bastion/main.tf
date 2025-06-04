# Bastion Host Module - Main Configuration

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Create IAM role for the bastion host
resource "aws_iam_role" "bastion_role" {
  name = "${var.environment}-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-bastion-role"
    }
  )
}

# Create IAM instance profile for the bastion host
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.environment}-bastion-profile"
  role = aws_iam_role.bastion_role.name
}

# Attach SSM policy to allow Session Manager access (optional)
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create bastion host EC2 instance
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name

  user_data = <<-EOF
    #!/bin/bash
    # Update system packages
    dnf update -y
    
    # Set hostname
    hostnamectl set-hostname ${var.environment}-bastion
    
    # Configure SSH hardening (example)
    sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
    systemctl restart sshd
  EOF

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-bastion"
    }
  )

  # Wait for cloud-init to complete
  provisioner "remote-exec" {
    inline = ["echo 'Bastion host ready'"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file(var.private_key_path)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Optionally create an Elastic IP for the bastion host
resource "aws_eip" "bastion_eip" {
  count    = var.create_eip ? 1 : 0
  instance = aws_instance.bastion.id
  domain   = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-bastion-eip"
    }
  )
}