# Proxmox VM Deployment with Tailscale and Docker

This project uses Terraform to automate the deployment of Ubuntu virtual machines on a Proxmox hypervisor. The VMs are configured with Tailscale for secure networking and Docker for containerization.

Inspiration for this project comes from the [Automate your Tailscale cloud deploymetns with Terraform IaC](https://youtu.be/PEoMmZOj6Cg?si=rb3fFzRzMMPGUzrm)

## Features

- Automated VM creation from a template
- Cloud-init configuration for initial setup
- Tailscale integration for secure networking
- Docker pre-installed on each VM
- Customizable VM specifications (CPU, memory, disk size)
- Support for deploying multiple VMs

## Prerequisites

- Proxmox VE server
- Terraform installed on your local machine
- Tailscale account and auth key
- Ubuntu 22.04 template available on your Proxmox server

## Configuration

1. Clone this repository to your local machine.

2. Create a `terraform.tfvars` file in the project root and add the following variables:

```hcl
proxmox_api_url = "https://your-proxmox-server:8006/api2/json"
proxmox_api_token_id = "your-api-token-id"
proxmox_api_token_secret = "your-api-token-secret"
pve_password = "your-proxmox-password"
tailscale_auth_key = "your-tailscale-auth-key"
```

3. Adjust other variables in `variables.tf` as needed (e.g., VM count, resources, network settings).

## Usage

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Review the planned changes:
   ```
   terraform plan
   ```

3. Apply the configuration:
   ```
   terraform apply
   ```

4. To destroy the created resources:
   ```
   terraform destroy
   ```

## Customization

- Modify `files/user_data.tftpl` to adjust the cloud-init configuration.
- Update `variables.tf` to change default values or add new variables.
- Edit the `proxmox_vm_qemu` resource in `main.tf` to alter VM configurations.

## Security Notes

- SSH password authentication is disabled by default.
- An `ansible` user is created with sudo privileges (password-less).
- Tailscale is configured to accept routes and enable SSH access.
