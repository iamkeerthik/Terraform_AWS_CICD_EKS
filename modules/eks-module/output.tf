output "cluster_id" {
  value = aws_eks_cluster.devops-eks.cluster_id
}

output "eks_nodegroup_id" {
  value = aws_eks_node_group.worker-node-group.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.devops-eks.endpoint
}

output "cluster_ca_cert" {
  value = aws_eks_cluster.devops-eks.certificate_authority
}

output "cluster_name" {
  value = aws_eks_cluster.devops-eks.name
}