resource "null_resource" "apply_config_map" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.name}-eks-cluster --region ${var.region} && eksctl create iamidentitymapping --cluster ${var.name}-eks-cluster --region ${var.region} --arn ${data.aws_iam_role.describe_role.arn} --username build --group system:masters  && eksctl utils associate-iam-oidc-provider --region ${var.region} --cluster ${var.name}-eks-cluster --approve  && eksctl delete iamserviceaccount  ${lower(var.name)}-alb-ingress-controller --cluster ${var.name}-eks-cluster --region ${var.region} --wait && eksctl create iamserviceaccount --cluster ${var.name}-eks-cluster --region ${var.region} --namespace=kube-system --name=${lower(var.name)}-alb-ingress-controller --role-name ${lower(var.name)}-AmazonEKSLoadBalancerControllerRole --attach-policy-arn=${data.aws_iam_policy.lbcIAMPolicy.arn} --override-existing-serviceaccounts --approve && helm repo add eks https://aws.github.io/eks-charts  && helm repo update && helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=${var.name}-eks-cluster --set serviceAccount.create=false --set serviceAccount.name=${lower(var.name)}-alb-ingress-controller"
  }
  # depends_on = [
  #   aws_eks_cluster.devops-eks
  # ]
}