provider "aws" {
  region = var.region
  default_tags {
    tags = var.default-tags
  }
}

terraform {
  backend "remote" {
    organization = "jan-nevaril-dev"

    workspaces {
      name = "c0_sandbox"
    }
  }
}

