#!/bin/bash

# Setup script for AWS EC2 Bastion Host Terraform Project

set -e

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}AWS EC2 Bastion Host Terraform Project Setup${NC}"
echo "----------------------------------------"

# Check if required tools are installed
echo -e "${YELLOW}Checking prerequisites...${NC}"

if ! command -v terraform &> /dev/null; then
    echo -e "${RED}Terraform not found. Please install Terraform.${NC}"
    echo "Visit: https://www.terraform.io/downloads.html"
    exit 1
fi

if ! command -v aws &> /dev/null; then
    echo -e "${RED}AWS CLI not found. Please install AWS CLI.${NC}"
    echo "Visit: https://aws.amazon.com/cli/"
    exit 1
fi

# Check AWS credentials
echo -e "${YELLOW}Checking AWS credentials...${NC}"
if ! aws sts get-caller-identity &> /dev/null; then
    echo -e "${RED}AWS credentials not configured or invalid.${NC}"
    echo "Run 'aws configure' to set up your credentials."
    exit 1
fi

# Ask for environment
echo -e "${YELLOW}Select environment to deploy:${NC}"
select env in "dev" "stage" "prod"; do
    case $env in
        dev|stage|prod)
            ENVIRONMENT=$env
            break
            ;;
        *) 
            echo -e "${RED}Invalid selection. Please select 1, 2, or 3.${NC}"
            ;;
    esac
done

# Navigate to the selected environment directory
cd "environments/$ENVIRONMENT"

# Initialize Terraform
echo -e "${YELLOW}Initializing Terraform in $ENVIRONMENT environment...${NC}"
terraform init

# Validate Terraform configuration
echo -e "${YELLOW}Validating Terraform configuration...${NC}"
terraform validate

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Terraform configuration is valid.${NC}"
    echo -e "${YELLOW}You can now run 'terraform plan' to see the execution plan.${NC}"
    echo -e "${YELLOW}Then run 'terraform apply' to create the resources.${NC}"
else
    echo -e "${RED}Terraform configuration is invalid. Please fix the errors and try again.${NC}"
    exit 1
fi

echo -e "${GREEN}Setup complete!${NC}"