provider "proxmox" {
  pm_api_url = "https://192.168.1.10:8006/api2/json"
  pm_user    = "root"
  pm_password = "root7538"
  insecure   = true
}

resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "devops-vm"
  target_node = "proxmox-node"
  iso         = "local:iso/ubuntu-22.04.iso"
  cores       = 2
  memory      = 2048
  sockets     = 1
  scsihw      = "virtio-scsi-pci"
  boot        = "cdn"
  ipconfig0   = "ip=192.168.100.10/24,gw=192.168.100.1"

  disk {
    size    = "10G"
    type    = "scsi"
    storage = "local-lvm"
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
}
