terraform {
region="eu-west-1"
}

provider "aws" {
  region = "eu-west-1"
}

module "test" {
  source = "../../modules/1"
}

