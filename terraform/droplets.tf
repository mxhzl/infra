data "digitalocean_ssh_key" "ssh_key" {
  name = "Rook"
}

resource "digitalocean_droplet" "mxhzl" {
  image  = "ubuntu-24-04-x64"
  name   = "mxhzl"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
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

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install caddy
      "sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl",
      "curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg",
      "curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list",
      "sudo apt update",
      "sudo apt install -y caddy"
    ]
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
