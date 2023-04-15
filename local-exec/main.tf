module "local-exec" {
  source = "../modules/local-provissioner"
  name = var.name
  region = var.region
}