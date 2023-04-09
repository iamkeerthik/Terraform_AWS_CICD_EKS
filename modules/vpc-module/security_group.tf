# Declare a variable for the security group rules
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
##############################################################################
# Security Groups
##############################################################################

resource "aws_security_group" "aws-eks-sg" {
  name   = "${var.name}-eks-sg"
  vpc_id = aws_vpc.myVPC.id

  # Use the variable for the security group rules
  ingress = [
    for rule in var.sg_rules :
    {
      description      = rule.description
      cidr_blocks      = [rule.cidr_block]
      from_port        = rule.from_port
      protocol         = rule.protocol
      security_groups  = [rule.security_group]
      to_port          = rule.to_port
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "${var.name}-eks-sg"
  }
}

resource "aws_security_group" "aws-rds-sg" {
  name   = "${var.name}-rds-sg"
  vpc_id = aws_vpc.myVPC.id

  # Use the variable for the security group rules
  ingress = [
    for rule in var.sg_rules :
    {
      description      = rule.description
      cidr_blocks      = [rule.cidr_block]
      from_port        = rule.from_port
      protocol         = rule.protocol
      security_groups  = [rule.security_group]
      to_port          = rule.to_port
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "${var.name}-rds-sg"
  }
}

############# Traffic between SG #############################

resource "aws_security_group_rule" "allow_rds_to_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-rds-sg.id
  source_security_group_id = aws_security_group.aws-eks-sg.id
}

