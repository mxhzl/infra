resource "digitalocean_database_cluster" "mxhzl" {
  name       = "mxhzl"
  engine     = "pg"
  version    = "17"
  size       = "db-s-1vcpu-1gb"
  region     = digitalocean_droplet.mxhzl.region
  node_count = 1
}

resource "digitalocean_database_firewall" "mxhzl" {
  cluster_id = digitalocean_database_cluster.mxhzl.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.mxhzl.id
  }
}

resource "digitalocean_database_user" "linkding" {
  cluster_id = digitalocean_database_cluster.mxhzl.id
  name       = "linkding"
}

resource "digitalocean_database_db" "mind_electric_production" {
  cluster_id = digitalocean_database_cluster.mxhzl.id
  name       = "mind_electric_production"
}

resource "digitalocean_database_db" "mind_electric_production_cache" {
  cluster_id = digitalocean_database_cluster.mxhzl.id
  name       = "mind_electric_production_cache"
}

resource "digitalocean_database_db" "mind_electric_production_queue" {
  cluster_id = digitalocean_database_cluster.mxhzl.id
  name       = "mind_electric_production_queue"
}

resource "digitalocean_database_db" "mind_electric_production_cable" {
  cluster_id = digitalocean_database_cluster.mxhzl.id
  name       = "mind_electric_production_cable"
}

resource "digitalocean_database_db" "linkding" {
  cluster_id = digitalocean_database_cluster.mxhzl.id
  name       = "linkding"
}