# Staging Environment Values

region             = "us-east-1"
vpc_cidr           = "10.1.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnets    = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
public_key_path    = "~/.ssh/id_rsa.pub"
private_key_path   = "~/.ssh/id_rsa"

# In a real environment, restrict this to your IP or VPN CIDR
allowed_cidr_blocks = ["0.0.0.0/0"]

tags = {
  Environment = "stage"
  Project     = "bastion-host"
  ManagedBy   = "terraform"
  Owner       = "devops-team"
}