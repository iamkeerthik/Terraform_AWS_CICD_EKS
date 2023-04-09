resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${lower(var.name)}-artifact-bucket-9588"
#   acl    = "private"

#   versioning {
#     enabled = false
#   }

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
}


# Define the CodePipeline
resource "aws_codepipeline" "example_pipeline" {
  name     = "${lower(var.name)}pipeline"
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifact_bucket.bucket
    type     = "S3"
  }

  # Define the source stage
  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceOutput"]
      configuration    = {
        RepositoryName = "${lower(var.name)}-repo"
         BranchName     = "master"
      }
    }
  }

  # Define the build stage
  stage {
    name = "Build"

    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]
      configuration    = {
        ProjectName = "${var.name}-build"
      }
    }
  }
}

# Define the IAM roles needed for the pipeline
resource "aws_iam_role" "pipeline_role" {
  name = "example-pipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "pipeline_policy" {
  policy_arn = "arn:aws:iam::237924323600:policy/AWSCodePipelineFullAccess"
  role       = aws_iam_role.pipeline_role.name
}

# resource "aws_iam_role_policy_attachment" "build_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
#   role       = aws_codebuild_project.example_build.service_role
# }