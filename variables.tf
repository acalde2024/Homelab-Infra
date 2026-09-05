variable "proxmox_endpoint" {
  description = "HTTPS URL of the Proxmox API"
  type        = string
}

variable "proxmox_api_token" {
  description = "API Token in the form USER@REALM!TOKENID=SECRET, e.g. root@pam!terraform=xxxx"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Name of the proxmox node"
  type        = string
}

variable "proxmox_insecure" {
  description = "Set to true to skip TLS verification"
  type        = bool
  default     = false
}
