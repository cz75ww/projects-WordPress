resource "aws_lb" "lb_sg" {
  name               = "fpsouza-lb-dev"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]

  tags = {
    Environment = "development"
  }
}

resource "aws_lb_target_group" "alb-target-group" {
  name        = "fpsouza-lb-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  health_check {
    healthy_threshold   = var.health_check.inputs.healthy_threshold
    interval            = var.health_check.inputs.interval
    unhealthy_threshold = var.health_check.inputs.unhealthy_threshold
    timeout             = var.health_check.inputs.timeout
    path                = var.health_check.inputs.path
    port                = var.health_check.inputs.port
  }
}

# resource "aws_lb_target_group_attachment" "tg_attachment_fpsouza" {
#   target_group_arn = aws_lb_target_group.alb-target-group.arn
#   target_id        = data.aws_instances.fpsouza_dev_ec2.id
#   port             = 80
#   depends_on = [
#     aws_autoscaling_group.asg_dev,
#     aws_launch_template.fpsouza_lt-dev
#   ]
# }

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.lb_sg.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.alb-target-group.arn
    type             = "forward"
  }
}
