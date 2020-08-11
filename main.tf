terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "debruyn"

    workspaces {
      name = "homelab"
    }
  }