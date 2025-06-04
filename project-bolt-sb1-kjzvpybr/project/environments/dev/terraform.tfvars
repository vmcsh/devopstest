# Development Environment Values

region             = "us-east-1"
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
public_key_path    = "~/.ssh/id_rsa.pub"
private_key_path   = "~/.ssh/id_rsa"

# In a real environment, restrict this to your IP or VPN CIDR
allowed_cidr_blocks = ["0.0.0.0/0"]

tags = {
  Environment = "dev"
  Project     = "bastion-host"
  ManagedBy   = "terraform"
  Owner       = "devops-team"
}