# AWS EC2 Bastion Host Terraform Project

This project demonstrates how to create EC2 bastion hosts across multiple environments (dev, stage, prod) using Terraform modules. It automatically selects the latest Amazon Linux 2023 AMI.

## Project Structure

```
.
├── main.tf                 # Main configuration
├── variables.tf            # Root input variables
├── outputs.tf              # Root outputs
├── providers.tf            # AWS provider configuration
├── modules/                # Reusable modules
│   └── bastion/            # Bastion host module
│       ├── main.tf         # Module resources
│       ├── variables.tf    # Module variables
│       ├── outputs.tf      # Module outputs
│       └── security.tf     # Security group configuration
└── environments/           # Environment-specific configurations
    ├── dev/                # Development environment
    ├── stage/              # Staging environment
    └── prod/               # Production environment
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- AWS CLI configured with appropriate credentials
- SSH key pair

## Usage

1. Initialize Terraform in the desired environment directory:

```bash
cd environments/dev
terraform init
```

2. Review the execution plan:

```bash
terraform plan
```

3. Apply the configuration:

```bash
terraform apply
```

4. To destroy the resources:

```bash
terraform destroy
```

## Connecting to the Bastion Host

Once provisioned, you can connect to the bastion host using:

```bash
ssh -i /path/to/your/key.pem ec2-user@<bastion-public-ip>
```

The public IP address is available in the Terraform outputs.