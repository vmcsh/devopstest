#!/bin/bash

# Cleanup script for AWS EC2 Bastion Host Terraform Project

set -e

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${RED}AWS EC2 Bastion Host Terraform Project Cleanup${NC}"
echo "--------------------------------------------"

# Ask for environment
echo -e "${YELLOW}Select environment to destroy:${NC}"
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

# Confirm destruction
echo -e "${RED}WARNING: This will destroy all resources in the $ENVIRONMENT environment.${NC}"
echo -e "${RED}This action cannot be undone.${NC}"
echo -n "Are you sure you want to continue? (y/n): "
read confirmation

if [ "$confirmation" != "y" ]; then
    echo -e "${GREEN}Cleanup aborted.${NC}"
    exit 0
fi

# Run terraform destroy
echo -e "${YELLOW}Destroying resources in $ENVIRONMENT environment...${NC}"
terraform destroy -auto-approve

if [ $? -eq 0 ]; then
    echo -e "${GREEN}All resources have been destroyed successfully.${NC}"
else
    echo -e "${RED}Failed to destroy some resources. Please check the error messages and try again.${NC}"
    exit 1
fi

echo -e "${GREEN}Cleanup complete!${NC}"