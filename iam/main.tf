
terraform {
  backend "local" {
    path = "backend/iam-terraform.tfstate"
  }
}
module "iam" {
  source = "../modules/iam-module"
}
