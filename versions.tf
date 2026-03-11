terraform {
  required_providers {
    forgejo = {
      source  = "svalabs/forgejo"
      version = ">= 1, <2"
    }
  }
}

provider "forgejo" {
  host      = var.host
  api_token = var.api_token
}
