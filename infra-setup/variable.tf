############____VPC____###################

variable "name" {
  description = "Tag Name to be assigned with resources"
  type        = string

}

variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type        = string
}

variable "public_subnets_cidr_1" {
  description = "Cidr Blocks"
  type        = string
}

variable "public_subnets_cidr_2" {
  description = "Cidr Blocks"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type        = bool
  default     = true
}

variable "private_subnets_cidr_1" {
  description = "mention the CIDR block for database subnet"
  type        = string
}
variable "private_subnets_cidr_2" {
  description = "mention the CIDR block for database subnet"
  type        = string
}

variable "enable_dhcp_options" {
  description = "Enable DHCP options.. True or False"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
}
variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
}

variable "manage_default_route_table" {
  description = "Are we managing default route table"
  type        = bool
}

variable "sg_rules" {
  type = list(object({
    description    = string,
    cidr_block     = string,
    from_port      = number,
    protocol       = string,
    security_group = string,
    to_port        = number,
  }))
}
#####################EKS####################

variable "asg_desired_size" {
  type = number
}

variable "asg_max_size" {
  type = number
}

variable "asg_min_size" {
  type = number
}

# variable "launch_template_id" {
#   type = string
# }

# variable "launch_template_version" {
# }

variable "endpoint_private_access" {
  type = bool
}
variable "endpoint_public_access" {
  type = bool
}

variable "eks_version" {
  type = number
}

variable "eks_instance_type" {
  type = string
}

variable "cluster_role_name" {
  type = string
}
variable "node_role_name" {
  type = string
}
variable "region" {
  type = string
}

######################RDS############################
variable "engine_name" {
  description = "Enter the DB engine"
  type        = string
}
variable "user_name" {
  description = "Enter the username for DB"
  type        = string
}
variable "pass" {
  description = "Enter the username for DB"
  type        = string
}
variable "multi_az_deployment" {
  description = "Enable or disable multi-az deployment"
  type        = bool
  default     = false
}
variable "public_access" {
  description = "Whether public access needed"
  type        = bool
  default     = false
}
variable "skip_finalSnapshot" {
  type    = bool
  default = true
}
variable "delete_automated_backup" {
  type    = bool
  default = true
}
variable "instance_class" {
  type    = string
}