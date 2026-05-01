output "reserved_ip" {
  value     = digitalocean_reserved_ip.hexware.ip_address
  sensitive = true
}

output "pg_service_uri" {
  value     = aiven_pg.hexware_db.service_uri
  sensitive = true
}