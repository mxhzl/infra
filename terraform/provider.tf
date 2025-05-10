provider "digitalocean" {
  token = var.do_token
}

provider "b2" {
  application_key = var.b2_application_key
  application_key_id = var.b2_application_key_id
}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    b2 = {
      source = "Backblaze/b2"
      version = "0.10.0"
    }
  }

  cloud {
    organization = "mxhzl"

    workspaces {
      name = "mxhzl_com"
    }
  }
}
