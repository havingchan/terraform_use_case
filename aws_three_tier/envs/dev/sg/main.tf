provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "internet_facing_lb_sg" {
  name        = "internet_facing_lb_sg"
  description = "Security group for internet-facing load balancer"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "HTTP from any IPv4"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Internet-Facing-LB-SG"
  }
}

resource "aws_security_group" "web_instance_sg" {
  name        = "web_instance_sg"
  description = "Security group for Web Instance"
  vpc_id      = data.aws_vpc.vpc.id


  ingress {
    description     = "HTTP from internet-facing-lb-sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.internet_facing_lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-Instance-SG"
  }
}

resource "aws_security_group" "internal_lb_sg" {
  name        = "internal_lb_sg"
  description = "Security group for internal load balancer"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description     = "HTTP from Web-Instance-SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_instance_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Internal-LB-SG"
  }
}

resource "aws_security_group" "app_instance_sg" {
  name        = "app_instance_sg"
  description = "Security group for private instances"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description     = "Custom TCP 4000 from internal-lb-sg"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_lb_sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "App-Instance-SG"
  }
}

resource "aws_security_group" "db_instance_sg" {
  name        = "db_instance_sg"
  description = "Security group for database"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description     = "MySQL/Aurora from PrivateInstanceSG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_instance_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DB-Instance-SG"
  }
}