variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "pve_user" {
  type    = string
  default = "root"
}

variable "pve_password" {
  type      = string
  sensitive = true
}

variable "pve_ip_address" {
  default = "192.168.2.10"
  type    = string
}

variable "proxmox_host" {
  default = "pve"
  type    = string
}

variable "server_vmid_begin" {
  default = 200
  type    = number
}

variable "template_name" {
  default = "ubuntu-22.04-server"
  type    = string
}

variable "server_cores" {
  default = 2
  type    = number
}

variable "server_memory" {
  default = 4096
  type    = number
}

variable "server_disk_size" {
  default = "40"
  type    = string
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "proxmox_storage" {
  default = "local-lvm"
  type    = string
}

variable "proxmox_network_device" {
  default = "vmbr0"
  type    = string
}

variable "working_directory" {
  description = "Working directory where cloud-init template is stored"
  type        = string
  default     = "."
}

variable "ssh_public_key" {
  description = "Path to SSH public key used for access"
  type        = string
  default     = "~/.ssh/ansible-es.pub"
}

variable "vm_template" {
  description = "The name of the VM template to clone"
  type        = string
  default     = "ubuntu-22.04-server"
}

variable "vm_name" {
  description = "Base name for the VMs"
  type        = string
  default     = "tailnet-vm"
}


variable "tailscale_auth_key" {
  description = "tailscale auth key"
  type        = string
  sensitive   = true
}
