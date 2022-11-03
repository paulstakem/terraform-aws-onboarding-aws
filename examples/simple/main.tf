locals {
  external_id = "abc123"
}

provider "aws" {
  region = var.region
}

module "orca" {
  source           = "../../"
  role_external_id = local.external_id
}
