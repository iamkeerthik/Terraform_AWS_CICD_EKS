module "ecr" {
  source ="../modules/ecr-module"
  name = var.name
}

module "code_commit" {
  source = "../modules/code-commit-module"
  depends_on = [
    module.ecr
  ]
  name = var.name
}

module "code_build" {
  source = "../modules/code-build-module"
  depends_on = [
    module.code_commit
  ]
  name = var.name
}

module "code_pipeline" {
  source = "../modules/code-pipeline-module"
  depends_on = [
    module.code_build
  ]
  name = var.name
}