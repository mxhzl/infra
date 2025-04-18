data "digitalocean_ssh_key" "ssh_key" {
  name = "Rook"
}

resource "digitalocean_droplet" "mxhzl" {
  image  = "ubuntu-24-04-x64"
  name   = "mxhzl"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
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

resource "digitalocean_firewall" "mxhzl" {
  name = "inbound-22-80-443-only"

  droplet_ids = [digitalocean_droplet.mxhzl.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
