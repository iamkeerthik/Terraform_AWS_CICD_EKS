resource "aws_ecr_repository" "my_ecr_repo" {
  name = "${lower(var.name)}_repo"

  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

#   lifecycle_policy {
#     policy = <<POLICY
# {
#   "rules": [
#     {
#       "rulePriority": 1,
#       "description": "Expire untagged images older than 30 days",
#       "selection": {
#         "tagStatus": "untagged",
#         "countType": "sinceImagePushed",
#         "countUnit": "days",
#         "countNumber": 30
#       },
#       "action": {
#         "type": "expire"
#       }
#     }
#   ]
# }
# POLICY
#   }
}
