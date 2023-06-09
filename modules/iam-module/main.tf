#EKS_CLUSTER_ROLE
resource "aws_iam_role" "eks-cluster-role" {
  name = "suremdm-eks-cluster-role"

  path = "/"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

#WORKER_NODE_ROLE
resource "aws_iam_role" "workernode_role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workernode_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workernode_role.name
}

resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.workernode_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workernode_role.name
}


###################CICD######################
resource "aws_iam_role" "codebuild_role" {
  name = "codebuild_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# resource "aws_iam_role_policy" "cloudbuild_policy" {
#   role = aws_iam_role.codebuild_role.name

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = [
#           "ecr:*"
#         ],
#         Effect = "Allow",
#         Resource = "*"
#       }
#     ]
#   })
# }
# resource "aws_iam_role_policy_attachment" "code_build_policy_attachment" {
#   policy_arn = aws_iam_policy.cloudbuild_policy.arn
#   role       = aws_iam_role.codebuild_role.name
# }

# Create an IAM role for the CodePipeline service to assume
resource "aws_iam_role" "codepipeline" {
  name = "my-pipeline-role"

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

# Attach a policy to the CodePipeline role to allow access to the ECR repository
resource "aws_iam_role_policy_attachment" "codepipeline_ecr_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = aws_iam_role.codepipeline.name
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = aws_iam_role.codebuild_role.name
}
#######################EKS Describe ##################
resource "aws_iam_policy" "eks_describe_policy" {
  name        = "eks-describe-policy"
  path        = "/"
  description = "Custom policy for EKS describe access"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "eks:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "eks_describe_role" {
  name = "eks-describe-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_describe_policy" {
  policy_arn = aws_iam_policy.eks_describe_policy.arn
  role       = aws_iam_role.eks_describe_role.name
}

##################################################
resource "aws_iam_policy" "eks_assume_role_policy" {
  name        = "eks-codebuild-sts-assume-role"
  description = "CodeBuild to interact with EKS cluster to perform changes"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sts:AssumeRole"
        Effect   = "Allow"
        Resource = aws_iam_role.eks_describe_role.arn
      }
    ]
  })
  depends_on = [
    aws_iam_role.codebuild_role,
    aws_iam_role.eks_describe_role
  ]
}

resource "aws_iam_role_policy_attachment" "code_build_policy_attachment_2" {
  policy_arn = aws_iam_policy.eks_assume_role_policy.arn
  role       = aws_iam_role.codebuild_role.name
}