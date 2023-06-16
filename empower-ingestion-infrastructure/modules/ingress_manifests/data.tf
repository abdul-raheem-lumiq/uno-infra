data "aws_lb" "ingress_alb" {
  depends_on = [resource.time_sleep.wait_300_seconds]
  name = var.alb_name
}