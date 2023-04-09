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


resource "null_resource" "apply_config_map" {
  provisioner "local-exec" {
    command = "eksctl create iamidentitymapping --cluster ${aws_eks_cluster.devops-eks.name} --arn ${data.aws_iam_role.describe_role.arn} --username build --group system:masters"
  }

  depends_on = [
    aws_eks_cluster.devops-eks
  ]
}