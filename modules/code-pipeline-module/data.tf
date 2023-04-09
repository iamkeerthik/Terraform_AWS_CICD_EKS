# data "aws_codebuild_project" "my_project" {
#   name = "${var.name}-build"
# }
data "aws_codecommit_repository" "my_repo" {
  repository_name = "${lower(var.name)}-repo"
}