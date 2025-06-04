# Production Environment Values

region             = "us-east-1"
vpc_cidr           = "10.2.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
private_subnets    = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
public_key_path    = "~/.ssh/id_rsa.pub"
private_key_path   = "~/.ssh/id_rsa"

# In a real environment, restrict this to corporate network CIDR or VPN
allowed_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12"]

tags = {
  Environment = "prod"
  Project     = "bastion-host"
  ManagedBy   = "terraform"
  Owner       = "devops-team"
  CostCenter  = "infrastructure"
}