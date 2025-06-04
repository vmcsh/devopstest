# Provider Configuration

provider "aws" {
  region = "us-east-1"

  # Uncomment to use a specific profile
  # profile = "default"

  # Default tags applied to all resources
  default_tags {
    tags = {
      Project     = "bastion-host"
      ManagedBy   = "terraform"
    }
  }
}