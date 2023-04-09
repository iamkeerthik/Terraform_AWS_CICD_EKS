# Create AWS CodeCommit Repository
resource "aws_codecommit_repository" "my_repo" {
  repository_name = "${lower(var.name)}-repo"
  description     = "My CodeCommit repository"
  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}