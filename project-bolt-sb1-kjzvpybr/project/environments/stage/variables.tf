# Staging Environment Variables

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
}

variable "public_key_path" {
  description = "Path to the public key for SSH access"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private key for SSH access"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to connect to the bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # In production, restrict to your IP or VPN
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "stage"
    Project     = "bastion-host"
    ManagedBy   = "terraform"
  }
}