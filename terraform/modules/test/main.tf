terraform {
  region = "eu-west-1"
}

provider "aws" {
  region = "eu-west-1"
}

module "test" {
  source       = "../../modules/1"
  organisation = "x"
  environment  = "test"
  entity       = "sales"

  tags {
    owner = "mikec"
  }
}
