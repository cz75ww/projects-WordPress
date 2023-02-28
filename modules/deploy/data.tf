data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_security_group" "public_group" {
  filter {
    name   = "tag:Name"
    values = [aws_security_group.public_sg.name]
  }
}

data "aws_security_group" "loadbalancer_group" {
  filter {
    name   = "tag:Name"
    values = [aws_security_group.lb_sg.name]
  }
}

data "aws_instances" "fpsouza_dev_ec2" {
  filter {
    name   = "tag:Name"
    values = ["AutoScaled"]
  }
  depends_on = [
    aws_autoscaling_group.asg_dev
  ]
}