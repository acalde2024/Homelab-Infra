# One resource block per existing LXC container
# After adding a block import with:
#   terraform import proxmox_virtual_environemt_container.<resource_name> <node>/<ctid>

resource "proxmox_virtual_environment_container" "jellyfin" {
  node_name     = var.proxmox_node
  vm_id         = 108
  description   = "jellyfin"
  tags          = ["terraform", "media"]
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
    size         = 16
  }

  mount_point {
    volume = "/mnt/media"
    path   = "/mnt/media"
  }

  device_passthrough {
    path = "/dev/dri/card0"
    gid  = 44
    mode = "0666"
    uid  = 0
  }

  device_passthrough {
    path = "/dev/dri/renderD128"
    gid  = 993
    mode = "0666"
    uid  = 0
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
    hostname = "jellyfin"

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