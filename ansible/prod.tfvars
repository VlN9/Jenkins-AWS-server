aws_region = "ca-central-1"

common_tags = {
  Owner       = "Nechay Vladimir"
  Project     = "WagtailWebApp"
  Environment = "prod"
}

replace_userdata_on_change = false

number_of_instances = 1

key_pair_name = "client_key-ca-central-1"

sg_cidr_rule = [
  {
    description = "HTTP ingress rule for all"
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "SSH ingress rule for me"
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "egress rule for all"
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

sg_self_rule = [
  {
    description = "rule for target group health_check"
    port        = 80
    protocol    = "tcp"
    type        = "ingress"
  }
]

security_group_rule_for_db = true

data_db_name = "terraform-wagtail-db"

zone_name = "vln.ink"