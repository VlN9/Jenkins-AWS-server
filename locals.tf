#==========Locals==========================
locals {
  name = "${var.common_tags["Project"]} ${var.common_tags["Environment"]}"
}