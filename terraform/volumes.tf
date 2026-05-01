resource "digitalocean_volume" "hexware" {
  region                  = digitalocean_droplet.hexware.region
  name                    = "hexware"
  size                    = 10
  initial_filesystem_type = "ext4"
}

resource "digitalocean_volume_attachment" "hexware" {
  droplet_id = digitalocean_droplet.hexware.id
  volume_id  = digitalocean_volume.hexware.id
}