
data "aws_availability_zones" "available_1" {
  state = "available"
}

data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["${var.name}-vpc"]
  }
}

data "aws_subnet" "subnet_1" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-private-subent-1a"]
  }
}

data "aws_subnet" "subnet_2" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[1]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-private-subent-1b"]
  }
}

data "aws_subnet" "subnet_3" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-public-subent-1a"]
  }
}

data "aws_subnet" "subnet_4" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[1]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-public-subent-1b"]
  }
}

data "aws_security_group" "rds-security" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["${var.name}-rds-sg"]
  }

}