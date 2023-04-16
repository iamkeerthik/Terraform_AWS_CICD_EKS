# data "aws_iam_role" "cluster_role" {
#   name = var.cluster_role_name
# }

# data "aws_iam_role" "node_role" {
#   name = var.node_role_name

# }
data "aws_iam_role" "describe_role" {
  name = "eks-describe-role"

}

data "aws_iam_policy" "lbcIAMPolicy" {
  name = "AWSLoadBalancerControllerIAMPolicy"
}

data "aws_iam_policy" "ebs-csi" {
  name = "AmazonEBSCSIDriverPolicy"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}