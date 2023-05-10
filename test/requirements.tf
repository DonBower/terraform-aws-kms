terraform {
  cloud {
    organization                        = "ag6hq"
    hostname                            = "app.terraform.io"

    workspaces {
      name                              = "terraform-aws-kms"
    }
  }
  required_providers {
    aws = {
      source                            = "hashicorp/aws"
    }
  }
}
