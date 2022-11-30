resource "aws_instance" "jen_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jen_sg.id]
  key_name               = data.aws_key_pair.jen_key.key_name

  tags = {
  Name        = "Jenkins-Server"
  Project     = var.common_tags["Project"]
  Owner       = var.common_tags["Owner"]
  Environment = var.common_tags["Environment"]
  }
}

resource "aws_security_group" "jen_sg" {
  name = "AWS_Jenkins_SG"
  tags = var.common_tags
}


resource "aws_security_group_rule" "cidr_rule_for_jen_sg" {
  count             = length(var.sg_cidr_rule) 
  description       = element(var.sg_cidr_rule, count.index)["description"]
  type              = element(var.sg_cidr_rule, count.index)["type"]
  from_port         = element(var.sg_cidr_rule, count.index)["from_port"]
  to_port           = element(var.sg_cidr_rule, count.index)["to_port"]
  protocol          = element(var.sg_cidr_rule, count.index)["protocol"]
  cidr_blocks       = element(var.sg_cidr_rule, count.index)["cidr_blocks"]
  security_group_id = aws_security_group.jen_sg.id

  depends_on = [
    aws_security_group.jen_sg
  ]
}


resource "aws_security_group_rule" "self_rule_for_jen_sg" {
  count                    = length(var.sg_self_rule)
  description              = element(var.sg_self_rule, count.index)["description"]
  type                     = element(var.sg_self_rule, count.index)["type"]
  from_port                = element(var.sg_self_rule, count.index)["port"]
  to_port                  = element(var.sg_self_rule, count.index)["port"]
  protocol                 = element(var.sg_self_rule, count.index)["protocol"]
  source_security_group_id = aws_security_group.jen_sg.id
  security_group_id        = aws_security_group.jen_sg.id

  depends_on = [
    aws_security_group.jen_sg
  ]
}


resource "aws_security_group_rule" "another_sg_rule_for_jen_sg" {
  count                    = length(var.sg_another_group_rule)
  description              = element(var.sg_another_group_rule, count.index)["description"]
  type                     = element(var.sg_another_group_rule, count.index)["type"]
  from_port                = element(var.sg_another_group_rule, count.index)["from_port"]
  to_port                  = element(var.sg_another_group_rule, count.index)["to_port"]
  protocol                 = element(var.sg_another_group_rule, count.index)["protocol"]
  source_security_group_id = element(var.sg_another_group_rule, count.index)["source_security_group_id"]
  security_group_id        = aws_security_group.jen_sg.id

  depends_on = [
    aws_security_group.jen_sg
  ]
}
