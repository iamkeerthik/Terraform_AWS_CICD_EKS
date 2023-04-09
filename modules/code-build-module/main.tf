resource "aws_codebuild_project" "eks_build" {
  name        = "${var.name}-build"
  description = "Example build project"
  service_role = data.aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "REPOSITORY_URI"
      value = data.aws_ecr_repository.ecr.repository_url
    }

    environment_variable {
      name  = "EKS_KUBECTL_ROLE_ARN"
      value = "${var.name}-eks-cluster"
    }

    environment_variable {
      name  = "EKS_CLUSTER_NAME"
      value = "${var.name}-eks-cluster"
    }
     environment_variable {
      name  = "REGION"
      value = "us-east-1"
    }
  }
  
  source  {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec.yaml"
    report_build_status = true
  }
  # source {
  #   type = "CODECOMMIT"
  #   location = data.aws_codecommit_repository.my_repo.clone_url_http
  # }
}

