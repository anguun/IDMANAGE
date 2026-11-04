# Blob Storage Identity and Access Lab

This project uses Terraform to build an Azure Storage Account with two private containers, `reports` and `restricted`. It also has code for an Entra ID app, a service principal and an RBAC role.

## What I built
- Resource group
- Storage account (HTTPS only, TLS 1.2, no public access)
- `reports` container (private)
- `restricted` container (private)

## How to run it
1. `az login`
2. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in your values
3. `terraform init`
4. `terraform apply`

## Security
- `terraform.tfvars` and state files are not in the repo
- No secrets or keys are stored in the code
- The role is meant to be on the `reports` container only (least privilege)

## Clean up
`terraform destroy`
