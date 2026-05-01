provider "digitalocean" {
  token = var.do_token
}

provider "porkbun" {
  api_key        = var.porkbun_api_key
  secret_api_key = var.porkbun_secret_api_key
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    porkbun = {
      source  = "kyswtn/porkbun"
      version = "0.1.3"
    }
  }

  cloud {
    organization = "hexware"

    workspaces {
      name = "hexware"
    }

  }
}
