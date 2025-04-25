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

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    timeout = "2m"
    agent_identity = "Rook"
  }

}

resource "digitalocean_reserved_ip" "mxhzl" {
  droplet_id = digitalocean_droplet.mxhzl.id
  region     = digitalocean_droplet.mxhzl.region
}

resource "digitalocean_volume" "mxhzl" {
  region                  = digitalocean_droplet.mxhzl.region
  name                    = "mxhzl"
  size                    = 10
  initial_filesystem_type = "ext4"
}

resource "digitalocean_volume_attachment" "mxhzl" {
  droplet_id = digitalocean_droplet.mxhzl.id
  volume_id  = digitalocean_volume.mxhzl.id
}
