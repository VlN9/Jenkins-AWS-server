aws_region = "ca-central-1"

key_pair_name = "vln-key-ca-central-1"

sg_cidr_rule = [
  {
    description = "SSH ingress rule for me"
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "HTTP ingress rule for internet"
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "HTTP ingress rule for listener"
    type        = "ingress"
    from_port   = 80
    to_port     = 80
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

home_path = "/home/vlad"

slave_key = "slave-ca-central-1.pem"

wagtail_key = "client_key-ca-central-1.pem"