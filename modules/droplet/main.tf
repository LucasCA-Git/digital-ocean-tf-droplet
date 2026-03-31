resource "digitalocean_droplet" "droplet" {
  name   = var.name
  region = var.region
  size   = var.size
  image  = var.image

  vpc_uuid = var.vpc_id

  ssh_keys = var.ssh_keys
}