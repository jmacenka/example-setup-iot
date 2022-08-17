# terraform script which defines the provider and variables required to complete the deployment

# defines the provider which here is DigitalOcean
terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.0.0"
    }
  }
}

# Variable which will hold the DigitalOcean API-key, operator will be prompted to input the value when starting the script. In production environment this would rather be handled by some mechanism like e.G. https://learn.hashicorp.com/tutorials/vault/terraform-secrets-engine
variable "do_token" {
    type = string
    description = "Please provide your DigitalOcean API Key to access the API/Backend via Terraform. If unclear visit: https://docs.digitalocean.com/reference/api/create-personal-access-token/"
    sensitive = true
}

# hand over the DigitalOcean token to the provider-object
provider "digitalocean" {
  token = var.do_token
}