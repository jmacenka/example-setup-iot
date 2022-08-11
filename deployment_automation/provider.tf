# terraform script which defines the provider and variables required to complete the deployment

# defines the provider which here is DigitalOcean
terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

# Variable which will hold the DigitalOcean API-key, operator will be prompted to input the value when starting the script. In production environment this would rather be handled by some mechanism like e.G. https://learn.hashicorp.com/tutorials/vault/terraform-secrets-engine
variable "do_token" {
    type = string
    description = "Please provide your DigitalOcean API Key to access the API/Backend via Terraform. If unclear visit: https://docs.digitalocean.com/reference/api/create-personal-access-token/"
    sensitive = true
}

# TODO: Check if needed, if not cleanup the code
variable "pvt_key" {
    default = "C:\\Users\\z003kc0z\\.ssh\\id_jan_SHS_ed25519"
}
# TODO: Check if needed, if not cleanup the code
variable "pub_key" {
    default = "C:\\Users\\z003kc0z\\.ssh\\id_jan_SHS_ed25519.pub"
}

# hand over the DigitalOcean token to the provider-object
provider "digitalocean" {
  token = var.do_token
}