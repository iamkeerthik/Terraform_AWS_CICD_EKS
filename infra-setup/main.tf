terraform {
  backend "local" {
    path = "backend/infra-terraform.tfstate"
  }
}

#use for remote backend as s3
# terraform {
#   backend "s3" {
#     bucket  = "terraform-statefiles-keerthik"
#     key     = "dev-test-env/infra-terraform.tfstate"
#     region  = "ap-south-1"
#     profile = "Test"
#   }
# }

module "vpc" {
    source = "../modules/vpc-module"
    name                       = var.name
    cidr                       = var.cidr
    public_subnets_cidr_1      = var.public_subnets_cidr_1
    public_subnets_cidr_2      = var.public_subnets_cidr_2
    private_subnets_cidr_1     = var.private_subnets_cidr_1
    private_subnets_cidr_2     = var.private_subnets_cidr_2
    map_public_ip_on_launch    = var.map_public_ip_on_launch
    enable_dhcp_options        = var.enable_dhcp_options
    enable_dns_hostnames       = var.enable_dns_hostnames
    enable_dns_support         = var.enable_dns_support
    enable_ipv6                = var.enable_ipv6
    manage_default_route_table = var.manage_default_route_table
    sg_rules                   = var.sg_rules
        
}


 module "eks" {
    source = "../modules/eks-module"
    depends_on = [
        module.vpc
    ]
    name                    = var.name
    asg_desired_size        = var.asg_desired_size
    asg_max_size            = var.asg_max_size
    asg_min_size            = var.asg_min_size
    # launch_template_id      = var.launch_template_id
    # launch_template_version = var.launch_template_version
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    eks_version             = var.eks_version
    eks_instance_type       = var.eks_instance_type
    cluster_role_name       = var.cluster_role_name
    node_role_name          = var.node_role_name
    region                  = var.region
}

# module "rds" {
#   source = "../modules/rds-module"
#   depends_on = [
#     module.vpc
#   ]
#   name =  var.name
#   engine_name = var.engine_name
#   instance_class = var.instance_class
#   user_name = var.user_name
#   pass =  var.pass
#   public_access = var.public_access
#   multi_az_deployment = var.multi_az_deployment
#   delete_automated_backup = var.delete_automated_backup
#   skip_finalSnapshot = var.skip_finalSnapshot
# }

module "local-exec" {
  source = "../modules/local-provissioner"
  depends_on = [
    module.eks
  ]
  name = var.name
  region = var.region
}