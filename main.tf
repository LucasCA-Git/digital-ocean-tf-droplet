data "digitalocean_project" "lab" {
  name = "lab-cicd"
}
module "network" {
  source = "./modules/network"

  region       = var.region
  vpc_name     = var.vpc_name
  vpc_ip_range = var.vpc_ip_range
}

module "droplet" {
  source = "./modules/droplet"

  name     = var.droplet_name
  region   = var.region
  size     = var.droplet_size
  image    = var.image
  vpc_id   = module.network.vpc_id
  ssh_keys = var.ssh_keys
}

resource "digitalocean_project_resources" "attach" {
  project = data.digitalocean_project.lab.id

  resources = [
    module.droplet.droplet_urn
  ]
}