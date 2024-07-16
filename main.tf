# # Filter out local zones, which are not currently supported
# # with managed node groups

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


locals {
  name        = "sock-shop-mai24"
  bucket_name = "aws-sock-shop-mai24-infra-state.file"
  region      = "eu-west-3"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    GithubRepo = "infra"
    GithubOrg  = local.name
  }
}

