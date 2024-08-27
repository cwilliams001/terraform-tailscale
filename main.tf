/* Generate the Cloud-Init user data files */
resource "local_file" "cloud_init_user_data_file_vm" {
  count = var.vm_count
  content = templatefile(
    "${var.working_directory}/files/user_data.tftpl", 
    { 
      hostname = "${var.vm_name}-${count.index}",
      tailscale_auth_key = var.tailscale_auth_key
    }
  )
  filename = "${path.module}/files/user_data_vm${count.index}.cfg"
}

resource "null_resource" "upload_cloud_init_user_data" {
  count = var.vm_count

  connection {
    type     = "ssh"
    user     = var.pve_user
    password = var.pve_password
    host     = var.pve_ip_address
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_file_vm[count.index].filename
    destination = "/var/lib/vz/snippets/user_data_vm_${count.index}.cfg"
  }
}

/* Create VMs using the cloned template and custom Cloud-Init configuration */
resource "proxmox_vm_qemu" "cloud-init-test" {
  name        = "${var.vm_name}-${count.index}"
  count       = var.vm_count
  desc        = "Ubunutu VM connected to the tailnet and docker installed"
  vmid        = var.server_vmid_begin + count.index + 1
  target_node = var.proxmox_host
  onboot      = true
  clone       = var.template_name
  cicustom    = "user=local:snippets/user_data_vm_${count.index}.cfg"
  ipconfig0   = "ip=dhcp"
  full_clone  = true
  agent       = 1
  os_type     = "cloud-init"
  cores       = var.server_cores
  sockets     = 1
  cpu         = "max"
  memory      = var.server_memory
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          size       = var.server_disk_size
          storage    = var.proxmox_storage
          emulatessd = true
        }
      }

      scsi1 {
        cloudinit {
          storage = var.proxmox_storage
        }
      }
    }
  }

  network {
    bridge = var.proxmox_network_device
    model  = "virtio"
  }

  lifecycle {
    ignore_changes = [
      network,
      ciuser,
      qemu_os
    ]
  }
}