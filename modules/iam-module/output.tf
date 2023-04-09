output "cluster_role_name" {
  value = aws_iam_role.eks-cluster-role.name
}

output "worker_role_name" {
  value = aws_iam_role.workernode_role.name
}