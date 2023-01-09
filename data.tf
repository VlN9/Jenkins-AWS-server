data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "aws_key_pair" "jen_key" {
  key_name = var.key_pair_name
}

data "aws_key_pair" "slave_key" {
  key_name = "slave-ca-central-1"
}

data "aws_subnets" "default" {}

data "aws_vpc" "default" {}

data "aws_route53_zone" "main_zone" {
  name         = var.zone_name
  private_zone = false
}
