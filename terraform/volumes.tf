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