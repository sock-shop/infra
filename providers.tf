terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.57"
    }
  }
}

provider "aws" {
  region                   = "eu-west-3"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "student16_mai24_bootcamp_devops_sock-shop"
}
