# Bastion Host Module - Variables

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the bastion host will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the bastion host will be deployed"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the bastion host"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private SSH key for provisioning"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to connect to the bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 10
}

variable "create_eip" {
  description = "Whether to create an Elastic IP for the bastion host"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}