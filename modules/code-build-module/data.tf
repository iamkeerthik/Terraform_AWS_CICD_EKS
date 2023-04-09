data "aws_ecr_repository" "ecr" {
  name = "${lower(var.name)}_repo"
}
data "aws_iam_role" "codebuild_role" {
  name = "codebuild_role"
}
data "aws_codecommit_repository" "my_repo" {
  repository_name = "${lower(var.name)}-repo"
}

