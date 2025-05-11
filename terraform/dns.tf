resource "porkbun_dns_record" "mxhzldotcom" {
  domain   = "mxhzl.com"
  type     = "A"
  content  = digitalocean_reserved_ip.mxhzl.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-mxhzldotcom" {
  domain   = "mxhzl.com"
  type     = "AAAA"
  content  = digitalocean_droplet.mxhzl.ipv6_address
  priority = 0
}

resource "porkbun_dns_record" "www" {
  domain   = "mxhzl.com"
  name     = "www"
  type     = "A"
  content  = digitalocean_reserved_ip.mxhzl.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-www" {
  domain   = "mxhzl.com"
  name     = "www"
  type     = "AAAA"
  content  = digitalocean_droplet.mxhzl.ipv6_address
  priority = 0
}

resource "porkbun_dns_record" "links" {
  domain   = "mxhzl.com"
  name     = "links"
  type     = "A"
  content  = digitalocean_reserved_ip.mxhzl.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-links" {
  domain   = "mxhzl.com"
  name     = "links"
  type     = "AAAA"
  content  = digitalocean_droplet.mxhzl.ipv6_address
  priority = 0
}

resource "porkbun_dns_record" "git" {
  domain   = "mxhzl.com"
  name     = "git"
  type     = "A"
  content  = digitalocean_reserved_ip.mxhzl.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-git" {
  domain   = "mxhzl.com"
  name     = "git"
  type     = "AAAA"
  content  = digitalocean_droplet.mxhzl.ipv6_address
  priority = 0
}

resource "porkbun_dns_record" "pronouns" {
  domain   = "mxhzl.com"
  name     = "pronouns"
  type     = "A"
  content  = digitalocean_reserved_ip.mxhzl.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-pronouns" {
  domain   = "mxhzl.com"
  name     = "pronouns"
  type     = "AAAA"
  content  = digitalocean_droplet.mxhzl.ipv6_address
  priority = 0
}

resource "porkbun_dns_record" "mood" {
  domain   = "mxhzl.com"
  name     = "mood"
  type     = "A"
  content  = digitalocean_reserved_ip.mxhzl.ip_address
  priority = 0
}

resource "porkbun_dns_record" "ipv6-mood" {
  domain   = "mxhzl.com"
  name     = "mood"
  type     = "AAAA"
  content  = digitalocean_droplet.mxhzl.ipv6_address
  priority = 0
}

resource "porkbun_dns_record" "login" {
  domain   = "mxhzl.com"
  name     = "login"
  type     = "CNAME"
  content  = "dev-hm81qsxxgomohk7k-cd-ajodorookt4lchcs.edge.tenants.us.auth0.com"
  priority = 0
}
