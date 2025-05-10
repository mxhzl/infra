data "digitalocean_ssh_key" "ssh_key" {
  name = "Rook"
}

resource "digitalocean_droplet" "mxhzl" {
  image  = "ubuntu-24-04-x64"
  name   = "mxhzl"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ipv6   = true
  backups = true
  backup_policy {
    plan    = "weekly"
    weekday = "SUN"
    hour    = 20
  }
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]
}

resource "digitalocean_reserved_ip" "mxhzl" {
  droplet_id = digitalocean_droplet.mxhzl.id
  region     = digitalocean_droplet.mxhzl.region
}