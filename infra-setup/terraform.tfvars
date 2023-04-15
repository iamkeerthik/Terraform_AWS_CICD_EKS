#################______VPC________##############
name                       = "Terraform"
cidr                       = "10.0.0.0/16"
public_subnets_cidr_1      = "10.0.1.0/24"
public_subnets_cidr_2      = "10.0.2.0/24"
private_subnets_cidr_1     = "10.0.3.0/24"
private_subnets_cidr_2     = "10.0.4.0/24"
map_public_ip_on_launch    = true
enable_dhcp_options        = true
enable_dns_hostnames       = true
enable_dns_support         = true
enable_ipv6                = true
manage_default_route_table = false

####################SG Rules####################
sg_rules = [
  {
    description    = "http"
    cidr_block     = "0.0.0.0/0"
    from_port      = 80
    protocol       = "tcp"
    security_group = "Terraform-eks-sg"
    to_port        = 80
  },
  {
    description    = "ssh"
    cidr_block     = "10.0.0.0/16"
    from_port      = 22
    protocol       = "tcp"
    security_group = "Terraform-eks-sg"
    to_port        = 22
  }
]

#################_______EKS_________##############
asg_desired_size        = 2
asg_max_size            = 2
asg_min_size            = 1
# launch_template_id      = "lt-03fbea4b65e2a13fe"
# launch_template_version = 2
endpoint_private_access = true
endpoint_public_access  = true
eks_version             = "1.23"
eks_instance_type       = "t2.micro"
cluster_role_name       = "suremdm-eks-cluster-role"
node_role_name          = "eks-node-group-role"
region                  = "us-east-1"

#####################RDS######################
  engine_name = "mysql"
  instance_class = "db.t2.micro"
  user_name = "kirik"
  pass =  "kirik.2023"
  public_access = false
  multi_az_deployment = false
  delete_automated_backup = true
  skip_finalSnapshot = true