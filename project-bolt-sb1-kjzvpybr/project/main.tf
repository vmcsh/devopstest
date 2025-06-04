# Root Terraform Configuration

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment to configure remote state storage
  # backend "s3" {
  #   bucket         = "terraform-state-bucket"
  #   key            = "bastion-host/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-state-lock"
  #   encrypt        = true
  # }
}

# This file is intentionally minimal.
# Environment-specific configurations are in the environments/ directory.