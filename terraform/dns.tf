resource "porkbun_dns_record" "links" {
  domain   = "hexware.dev"
  name     = "links"
  type     = "A"
  content  = digitalocean_reserved_ip.hexware.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-links" {
  domain   = "hexware.dev"
  name     = "links"
  type     = "AAAA"
  content  = digitalocean_droplet.hexware.ipv6_address
  priority = 0
}

resource "porkbun_dns_record" "git" {
  domain   = "hexware.dev"
  name     = "git"
  type     = "A"
  content  = digitalocean_reserved_ip.hexware.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-git" {
  domain   = "hexware.dev"
  name     = "git"
  type     = "AAAA"
  content  = digitalocean_droplet.hexware.ipv6_address
  priority = 0
}
