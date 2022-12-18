#==========Target=Group======================================================
resource "aws_lb_target_group" "jenkins_tg" {
  name     = "jentargetgroup"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    port                = 8080
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    matcher             = "403" # 403 code responce because for 200 code need to have permissions
  }

  tags = merge(var.common_tags, { Name = "${local.name}-Target-Group" })

  depends_on = [
    aws_instance.jen_server
  ]
}

resource "aws_lb_target_group_attachment" "jenkins_tg_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = aws_instance.jen_server.id
  port             = 8080

  depends_on = [
    aws_lb_target_group.jenkins_tg,
    aws_instance.jen_server
  ]
}
#==========Load=Balanser======================================================
resource "aws_lb" "jenkins_lb" {
  name               = "jenkinsloadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jen_sg.id]
  subnets            = [data.aws_subnets.default.ids[0], data.aws_subnets.default.ids[1]]

  depends_on = [
    aws_lb_target_group_attachment.jenkins_tg_attachment
  ]

  tags = merge(var.common_tags, { Name = "${local.name}-Load-Balancer" })
}

resource "aws_lb_listener" "wagtail_lb_listener" {
  load_balancer_arn = aws_lb.jenkins_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
  }

  depends_on = [
    aws_lb.jenkins_lb
  ]
}
#==========Route53=Record======================================================
resource "aws_route53_record" "wagtail" {
  zone_id = data.aws_route53_zone.vln.id
  name    = var.common_tags["Environment"] == "prod" ? "jenkins" : "jenkins-${var.common_tags["Environment"]}"
  type    = "A"

  alias {
    name                   = aws_lb.jenkins_lb.dns_name
    zone_id                = aws_lb.jenkins_lb.zone_id
    evaluate_target_health = true
  }

  depends_on = [
    aws_lb.jenkins_lb
  ]
}