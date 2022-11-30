variable "aws_region" {
  description = "AWS region to deploy"
  type = string
  default = "ca-central-1"
}

variable "sg_cidr_rule" {
  description = "list of parametres for server's security group ingress and egress rules. CIDR only"
  type        = list(any)
  default = [
    {
      type        = "ingress"
      description = " "
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

variable "sg_self_rule" {
  description = "list of parametres for server's security group ingress and egress rules. for group itself"
  type = list(any)
  default = []
}

variable "sg_another_group_rule" {
  description = "list of parametres for server's security group ingress and egress rules. For connection security group to another"
  type    = list(any)
  default = []
}

variable "server_counter" {
  description = "Number of servers"
  type = number
  default = 1
}

variable "instance_type" {
  description = "Type of instances"
  type = string
  default = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of key pair for SSH"
  type = string
  default = "vln-key-ca-central-1"
}

variable "common_tags" {
  description = "common tags for all resources"
  type        = map(any)
  default = {
    Owner       = "Nechay Vladimir"
    Project     = "Jenkins"
    Environment = "prod"
  }
}
