
# data "terraform_remote_state" "eks" {
#    backend = "s3"
#    config = {
#     bucket  = "terraform-statefiles-keerthik"
#     key     = "terraform/dev-test-env/"
#     region  = "ap-south-1"
#     profile = "PS"
#   }
# }

data "aws_availability_zones" "available_1" {
  state = "available"
}

data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["${var.name}-vpc"]
  }
}

data "aws_subnet" "subnet_1" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-private-subent-1a"]
  }
}

data "aws_subnet" "subnet_2" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[1]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-private-subent-1b"]
  }
}

data "aws_subnet" "subnet_3" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-public-subent-1a"]
  }
}

data "aws_subnet" "subnet_4" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[1]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-public-subent-1b"]
  }
}

data "aws_security_group" "eks-security" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["${var.name}-eks-sg"]
  }

}

data "aws_iam_role" "cluster_role" {
  name = var.cluster_role_name
}

data "aws_iam_role" "node_role" {
  name = var.node_role_name

}
data "aws_iam_role" "describe_role" {
  name = "eks-describe-role"

}

data "aws_iam_policy" "lbcIAMPolicy" {
  name = "AWSLoadBalancerControllerIAMPolicy"
}
data "tls_certificate" "eks" {
  url = aws_eks_cluster.suremdm-eks.identity.0.oidc.0.issuer
}
