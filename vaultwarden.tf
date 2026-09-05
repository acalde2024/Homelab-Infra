resource "proxmox_virtual_environment_container" "vaultwarden" {
  node_name     = var.proxmox_node
  vm_id         = 104
  description   = "Homarr webpage"
  tags          = ["terraform", "password-manager"]
  unprivileged  = true
  start_on_boot = true

  cpu {
    cores = 4
  }

  memory {
    dedicated = 6144
    swap      = 512
  }

  disk {
    datastore_id = "local"
    size         = 20
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
    hostname = "vaultwarden"

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