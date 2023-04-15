resource "aws_eks_cluster" "devops-eks" {
  name     = "${var.name}-eks-cluster"
  version  = var.eks_version
  role_arn = data.aws_iam_role.cluster_role.arn


  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids              = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
    security_group_ids      = [data.aws_security_group.eks-security.id]
  }

  tags = {
    Name = "${var.name}-eks-cluster"
  }

}


# resource "null_resource" "apply_config_map" {
#   # provisioner "local-exec" {
#   #   command = "eksctl create iamidentitymapping --cluster ${aws_eks_cluster.devops-eks.name} --region ${var.region} --arn ${data.aws_iam_role.describe_role.arn} --username build --group system:masters"
#   # }
#   provisioner "local-exec" {
#     command = <<EOF
#       eksctl create iamidentitymapping --cluster ${aws_eks_cluster.devops-eks.name} --region ${var.region} --arn ${data.aws_iam_role.describe_role.arn} --username build --group system:masters
#       eksctl utils associate-iam-oidc-provider --region ${var.region} --cluster ${aws_eks_cluster.devops-eks.name} --approve
#       eksctl create iamserviceaccount --cluster ${aws_eks_cluster.devops-eks.name} --region ${var.region} --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=${data.aws_iam_policy.lbcIAMPolicy.arn} --approve
#       helm repo add eks https://aws.github.io/eks-charts
#       helm repo update
#       helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=${aws_eks_cluster.devops-eks.name} --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
#     EOF
#   }
#   # depends_on = [
#   #   aws_eks_cluster.devops-eks
#   # ]
# }