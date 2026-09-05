resource "proxmox_virtual_environment_container" "speedtest" {
  node_name     = var.proxmox_node
  vm_id         = 110
  description   = "speedtest-tracker"
  tags          = ["terraform", "monitoring"]
  unprivileged  = true
  start_on_boot = true

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
    swap      = 512
  }

  disk {
    datastore_id = "local"
    size         = 4
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
    hostname = "speedtest"

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