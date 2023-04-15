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