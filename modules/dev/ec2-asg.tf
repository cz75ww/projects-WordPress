resource "aws_launch_template" "fpsouza_lt-dev" {
  name = "fpsouza-lt-dev"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  key_name = "cz75ww"



  image_id = data.aws_ami.ubuntu.id

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [data.aws_security_group.public_group.id, data.aws_security_group.loadbalancer_group.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "fpsouza-dev"
    }
  }

  user_data = filebase64("${path.module}/scripts/ec2-init.sh")
}

resource "aws_autoscaling_policy" "asp_dev" {
  name                   = "fpsouza-asp-dev"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_dev.name
}

resource "aws_autoscaling_group" "asg_dev" {
  name = "fpsouza-asg-dev"
  #vpc_zone_identifier = [for subnet in data.aws_subnet.subnet_values : subnet.id]
  vpc_zone_identifier = aws_subnet.public_subnet[*].id
  min_size            = 1
  max_size            = 3
  health_check_type   = "ELB"
  target_group_arns    = [aws_lb_target_group.alb-target-group.arn]

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id      = aws_launch_template.fpsouza_lt-dev.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "AutoScaled"
    propagate_at_launch = true
  }
  tag {
    key                 = "Initialized"
    value               = "false"
    propagate_at_launch = true
  }
}