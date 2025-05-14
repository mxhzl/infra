provider "digitalocean" {
  token = var.do_token
}

provider "b2" {
  application_key    = var.b2_application_key
  application_key_id = var.b2_application_key_id
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

    b2 = {
      source  = "Backblaze/b2"
      version = "0.10.0"
    }

    porkbun = {
      source  = "kyswtn/porkbun"
      version = "0.1.3"
    }
  }

  encryption {
    key_provider "pbkdf2" "key" {
      passphrase = var.passphrase
    }

    method "aes_gcm" "secure_method" {
      keys = key_provider.pbkdf2.key
    }

    state {
      method   = method.aes_gcm.secure_method
      enforced = true
    }
  }
}
