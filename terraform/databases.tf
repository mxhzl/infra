resource "aiven_pg" "hexware_db" {
  project      = "hexware"
  service_name = "hexware-db"
  plan         = "free-1-1gb"

  pg_user_config {
    ip_filter_string = [digitalocean_droplet.hexware.ipv4_address]
    pg_version       = "17"
  }
}

resource "aiven_pg_database" "linkding" {
  project       = aiven_pg.hexware_db.project
  service_name  = aiven_pg.hexware_db.service_name
  database_name = "linkding"
}

resource "aiven_pg_database" "forgejodb" {
  project       = aiven_pg.hexware_db.project
  service_name  = aiven_pg.hexware_db.service_name
  database_name = "forgejodb"
}

resource "aiven_pg_user" "linkding" {
  project      = aiven_pg.hexware_db.project
  service_name = aiven_pg.hexware_db.service_name
  username     = "linkding"
}

resource "aiven_pg_user" "forgejo" {
  project      = aiven_pg.hexware_db.project
  service_name = aiven_pg.hexware_db.service_name
  username     = "forgejo"
}