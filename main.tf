data "digitalocean_project" "sonarqube" {
  name = "SonarQube"
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

# ============================================================
# FLOATING IP (IP FIXO)
# ============================================================
# Esse recurso cria um Floating IP na DigitalOcean.
# O IP não é destruído junto com o Droplet.
# Assim, mesmo recriando a VM diariamente,
# o domínio continua apontando para o mesmo IP.
resource "digitalocean_floating_ip" "sonarqube_ip" {
  region = var.region
}

# ============================================================
# ASSOCIAÇÃO DO FLOATING IP AO DROPLET
# ============================================================
# Aqui o Floating IP é conectado ao Droplet criado pelo módulo.
# Sempre que o Droplet subir novamente,
# o Terraform reaplica o mesmo IP fixo nele.
resource "digitalocean_floating_ip_assignment" "sonarqube_ip_attach" {
  ip_address = digitalocean_floating_ip.sonarqube_ip.ip_address
  droplet_id = module.droplet.droplet_id
}

resource "digitalocean_project_resources" "attach" {
  project = data.digitalocean_project.sonarqube.id

  resources = [
    module.droplet.droplet_urn
  ]
}