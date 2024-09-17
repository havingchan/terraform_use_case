resource "aws_launch_template" "template" {
  name                   = var.template_name
  image_id               = data.aws_ami.ami.id
  instance_type          = var.instance_type
  # key_name               = data.aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = var.asg_name
  vpc_zone_identifier = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]
  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
  target_group_arns = [data.aws_lb_target_group.lbtg.arn]
  min_size          = var.asg_min_size
  max_size          = var.asg_max_size
  desired_capacity  = var.asg_desired_capacity
}