resource "b2_bucket" "pg-backups" {
  bucket_name = "mxhzl-pg-backups"
  bucket_type = "allPrivate"
  default_server_side_encryption {
    mode = "SSE-B2"
    algorithm = "AES256"
  }
}
