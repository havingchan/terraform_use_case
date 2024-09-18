resource "aws_lb_target_group" "lb_target_group" {
  name        = var.lb_target_group_name
  port        = var.lb_target_group_port
  protocol    = var.lb_target_group_protocol
  vpc_id      = data.aws_vpc.vpc.id
  target_type = var.lb_target_group_target_type
  health_check {
    path                = var.lb_target_group_health_check_path
    protocol            = var.lb_target_group_health_check_protocol
    port                = var.lb_target_group_health_check_port
    interval            = var.lb_target_group_health_check_interval
    timeout             = var.lb_target_group_health_check_timeout
    healthy_threshold   = var.lb_target_group_health_check_healthy_threshold
    unhealthy_threshold = var.lb_target_group_health_check_unhealthy_threshold
  }
  tags = {
    Name = var.lb_target_group_name
  }

}

resource "aws_lb" "lb" {
  name               = var.lb_name
  load_balancer_type = var.lb_type
  internal           = var.internal_bool
  security_groups    = [data.aws_security_group.sg.id]
  subnets            = [data.aws_subnet.subnet_app1.id, data.aws_subnet.subnet_app2.id]
  tags = {
    Name = var.lb_name
  }

}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  default_action {
    type             = var.lb_listener_default_action_type
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }

}