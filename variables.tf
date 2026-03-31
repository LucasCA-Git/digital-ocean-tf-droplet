variable "digitalocean_api_token" {
  description = "Token da DigitalOcean"
  type        = string
  sensitive   = true
}

variable "region" {
  type    = string
  default = "nyc1"
}

variable "droplet_name" {
  type    = string
  default = "meu-droplet"
}

variable "droplet_size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "image" {
  type    = string
  default = "ubuntu-22-04-x64"
}

variable "ssh_keys" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = list(string)
  default = []
}

# VPC
variable "vpc_name" {
  type    = string
  default = "vpc-terraform"
}

variable "vpc_ip_range" {
  type    = string
  default = "10.10.10.0/24"
}