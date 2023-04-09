resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.devops-eks.name
  node_group_name = "${var.name}-Nodegroup"
  node_role_arn   = data.aws_iam_role.node_role.arn
  subnet_ids      = [data.aws_subnet.subnet_3.id, data.aws_subnet.subnet_4.id]
  instance_types  = [var.eks_instance_type]


  tags = {
    Name        = "${var.name}-Nodegroup"
    Environment = var.name
  }

  scaling_config {
    desired_size = var.asg_desired_size
    max_size     = var.asg_max_size
    min_size     = var.asg_min_size
  }

#   launch_template {
#     id      = var.launch_template_id
#     version = var.launch_template_version
#   }

}