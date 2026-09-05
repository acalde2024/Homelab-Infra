resource "proxmox_virtual_environment_container" "homarr" {
  node_name     = var.proxmox_node
  vm_id         = 100
  description   = "Homarr webpage"
  tags          = ["Terraform"]
  unprivileged  = true
  start_on_boot = true

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
    swap      = 2048
  }

  disk {
    datastore_id = "local"
    size         = 8
  }

  network_interface {
    name    = "eth0"
    bridge  = "vmbr1"
    vlan_id = 10
  }

  features {
    nesting = true
  }

  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }

  operating_system {
    template_file_id = "local:vztmp/debian-13-standard_13.1-2_amd64.tar.zst"
    type             = "debian"
  }

  initialization {
    hostname = "Homarr"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  lifecycle {
    ignore_changes = [operating_system, features]
  }
}