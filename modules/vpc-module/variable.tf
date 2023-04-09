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

