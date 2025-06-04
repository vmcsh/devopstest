# Development Environment Configuration

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "bastion-host"
      ManagedBy   = "terraform"
    }
  }
}

# Create a VPC for the development environment
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "dev-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = var.tags
}

# Create an SSH key pair for the bastion host
resource "aws_key_pair" "bastion_key" {
  key_name   = "dev-bastion-key"
  public_key = file(var.public_key_path)

  tags = var.tags
}

# Create a bastion host in the development environment
module "bastion" {
  source = "../../modules/bastion"

  environment        = "dev"
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.public_subnets[0]
  instance_type      = "t3.micro"
  key_name           = aws_key_pair.bastion_key.key_name
  private_key_path   = var.private_key_path
  allowed_cidr_blocks = var.allowed_cidr_blocks
  root_volume_size   = 10
  create_eip         = true

  tags = var.tags
}

# Output the bastion host information
output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = module.bastion.bastion_public_ip
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  value       = module.bastion.bastion_private_ip
}

output "bastion_ami_id" {
  description = "ID of the AMI used for the bastion host"
  value       = module.bastion.bastion_ami_id
}

output "bastion_ami_name" {
  description = "Name of the AMI used for the bastion host"
  value       = module.bastion.bastion_ami_name
}

output "ssh_command" {
  description = "SSH command to connect to the bastion host"
  value       = module.bastion.ssh_command
}