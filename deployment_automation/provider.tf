terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}

variable "do_token" {
    type = string
    description = "Please provide your DigitalOcean API Key to access the API/Backend via Terraform. If unclear visit: https://docs.digitalocean.com/reference/api/create-personal-access-token/"
    sensitive = true
}
variable "pvt_key" {
    default = "C:\\Users\\z003kc0z\\.ssh\\id_jan_SHS_ed25519"
}
variable "pub_key" {
    default = "C:\\Users\\z003kc0z\\.ssh\\id_jan_SHS_ed25519.pub"
}

provider "digitalocean" {
  token = var.do_token
}

#data "digitalocean_ssh_key" "SHS_TE_ME_EOS_PIA_Demo" {
#    name = "SHS_TE_ME_EOS_PIA_Demo"
#}