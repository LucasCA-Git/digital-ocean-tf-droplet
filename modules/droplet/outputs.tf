output "droplet_urn" {
  value = digitalocean_droplet.droplet.urn
}

output "droplet_ip" {
  value = digitalocean_droplet.droplet.ipv4_address
}

output "droplet_id" {
  value = digitalocean_droplet.droplet.id
}