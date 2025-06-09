variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = ""
}

variable "user_data_replace_on_change" {
  description = "Whether to replace the instance when user_data changes"
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "The availability zone to launch the instance in"
  type        = string
}

variable "subnet_id" {
  description = "The VPC subnet ID to launch the instance in"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "iam_instance_profile_arm" {
  description = "The IAM instance profile name or ARN to associate"
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "volume_size" {
  description = "Size of the root EBS volume in GiB"
  type        = number
}

variable "volume_type" {
  description = "Type of EBS volume"
  type        = string
  default     = "gp2"
}

variable "root_block_device_tags" {
  description = "Tags to apply to the root block device"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "eip_domain" {
  description = "The domain for the Elastic IP (standard or vpc)"
  type        = string
  default     = "vpc"
}

variable "eip_tags" {
  description = "Additional tags to apply to the Elastic IP"
  type        = map(string)
  default     = {}
}

variable "cidr_blocks" {
  description = "List of CIDR blocks to allow SSH access from"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID for the security group"
  type        = string
}
