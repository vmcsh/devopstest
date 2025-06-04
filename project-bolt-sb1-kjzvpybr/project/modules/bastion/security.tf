# Bastion Host Module - Security Configuration

# Create security group for the bastion host
resource "aws_security_group" "bastion_sg" {
  name        = "${var.environment}-bastion-sg"
  description = "Security group for ${var.environment} environment bastion host"
  vpc_id      = var.vpc_id

  # Ingress rule for SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow SSH access from specified CIDR blocks"
  }

  # Egress rule for all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-bastion-sg"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Create additional security group rules if needed
resource "aws_security_group_rule" "additional_rules" {
  count = length(var.additional_security_group_rules)

  security_group_id = aws_security_group.bastion_sg.id
  type              = var.additional_security_group_rules[count.index].type
  from_port         = var.additional_security_group_rules[count.index].from_port
  to_port           = var.additional_security_group_rules[count.index].to_port
  protocol          = var.additional_security_group_rules[count.index].protocol
  cidr_blocks       = var.additional_security_group_rules[count.index].cidr_blocks
  description       = var.additional_security_group_rules[count.index].description
}

variable "additional_security_group_rules" {
  description = "List of additional security group rules to add to the bastion host security group"
  type = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}