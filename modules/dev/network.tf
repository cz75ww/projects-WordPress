resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = var.public_subnet_name[count.index]
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = var.private_subnet_name[count.index]
  }
}


resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_access_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "fpsouza-dev-public-route-table"
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  count          = length(var.public_subnet_name)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "fpsouza-dev-private-route-table"
  }
}

resource "aws_route_table_association" "rta_subnet_private" {
  count          = length(var.private_subnet_name)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "public_sg" {
  name   = "fpsouza-public-sg-dev"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ssh_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fpsouza-public-sg-dev"
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "fpsouza-rds-sg-dev"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.ingress_rds_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.lb_sg.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fpsouza-rds-sg-dev"
  }
}

resource "aws_security_group" "lb_sg" {
  name   = "fpsouza-lb-sg-dev"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.ingress_lb_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fpsouza-lb-sg-dev"
  }
}