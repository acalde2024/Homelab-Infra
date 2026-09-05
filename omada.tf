resource "proxmox_virtual_environment_container" "omada" {
  node_name     = var.proxmox_node
  vm_id         = 111
  description   = "omada"
  tags          = ["terraform", "tp-link", "controller", "wifi"]
  unprivileged  = true
  start_on_boot = true



  cpu {
    cores = 2
  }

  memory {
    dedicated = 3072
    swap      = 512
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
    keyctl  = true
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
    hostname = "omada"

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