provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "havingwebappbucket2" {
  bucket = "havingwebappbucket2"
}

resource "aws_iam_role" "havingwebappec2role2" {
  name = "havingwebappec2role2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]

  tags = {
    Name = "havingwebappec2role2"
  }
}

resource "aws_vpc" "havingwebappvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "havingwebappvpc"
  }
}

# Create subnets in different availability zones
resource "aws_subnet" "public_web_subnet_az_us_west_2a" {
  vpc_id            = aws_vpc.havingwebappvpc.id
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "Public-Web-Subnet-AZ-us-west-2a"
  }
}

resource "aws_subnet" "private_app_subnet_az_us_west_2a" {
  vpc_id            = aws_vpc.havingwebappvpc.id
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "Private-App-Subnet-AZ-us-west-2a"
  }
}

resource "aws_subnet" "private_db_subnet_az_us_west_2a" {
  vpc_id            = aws_vpc.havingwebappvpc.id
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "Private-DB-Subnet-AZ-us-west-2a"
  }
}

resource "aws_subnet" "public_web_subnet_az_us_west_2b" {
  vpc_id            = aws_vpc.havingwebappvpc.id
  availability_zone = "us-west-2b"
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "Public-Web-Subnet-AZ-us-west-2b"
  }
}

resource "aws_subnet" "private_app_subnet_az_us_west_2b" {
  vpc_id            = aws_vpc.havingwebappvpc.id
  availability_zone = "us-west-2b"
  cidr_block        = "10.0.4.0/24"
  tags = {
    Name = "Private-App-Subnet-AZ-us-west-2b"
  }
}

resource "aws_subnet" "private_db_subnet_az_us_west_2b" {
  vpc_id            = aws_vpc.havingwebappvpc.id
  availability_zone = "us-west-2b"
  cidr_block        = "10.0.5.0/24"
  tags = {
    Name = "Private-DB-Subnet-AZ-us-west-2b"
  }
}

resource "aws_internet_gateway" "havingwebappigw" {
  vpc_id = aws_vpc.havingwebappvpc.id
  tags = {
    Name = "havingwebappigw"
  }
}



# Create route tables
resource "aws_route_table" "havingwebapp_public_route_table" {
  vpc_id = aws_vpc.havingwebappvpc.id
  tags = {
    Name = "HavingWebAppPublicRouteTable"
  }
}

resource "aws_route_table" "havingwebapp_private_route_table_us_west_2a" {
  vpc_id = aws_vpc.havingwebappvpc.id
  tags = {
    Name = "HavingWebAppPrivateRouteTableUsEast2a"
  }
}

resource "aws_route_table" "havingwebapp_private_route_table_us_west_2b" {
  vpc_id = aws_vpc.havingwebappvpc.id
  tags = {
    Name = "HavingWebAppPrivateRouteTableUsEast2b"
  }
}

# Create route table associations
resource "aws_route_table_association" "public_web_subnet_az_us_west_2a_association" {
  subnet_id      = aws_subnet.public_web_subnet_az_us_west_2a.id
  route_table_id = aws_route_table.havingwebapp_public_route_table.id
}

resource "aws_route_table_association" "public_web_subnet_az_us_west_2b_association" {
  subnet_id      = aws_subnet.public_web_subnet_az_us_west_2b.id
  route_table_id = aws_route_table.havingwebapp_public_route_table.id
}

resource "aws_route_table_association" "private_app_subnet_az_us_west_2a_association" {
  subnet_id      = aws_subnet.private_app_subnet_az_us_west_2a.id
  route_table_id = aws_route_table.havingwebapp_private_route_table_us_west_2a.id
}

resource "aws_route_table_association" "private_app_subnet_az_us_west_2b_association" {
  subnet_id      = aws_subnet.private_app_subnet_az_us_west_2b.id
  route_table_id = aws_route_table.havingwebapp_private_route_table_us_west_2b.id
}

# Create routes
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.havingwebapp_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.havingwebappigw.id
}

resource "aws_route" "private_route_us_west_2a" {
  route_table_id         = aws_route_table.havingwebapp_private_route_table_us_west_2a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_us_west_2a.id
}

resource "aws_route" "private_route_us_west_2b" {
  route_table_id         = aws_route_table.havingwebapp_private_route_table_us_west_2b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_us_west_2b.id
}


resource "aws_security_group" "internet_facing_lb_sg" {
  name        = "internet-facing-lb-sg"
  description = "Security group for internet-facing load balancer"
  vpc_id      = aws_vpc.havingwebappvpc.id

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
    Name = "internet-facing-lb-sg"
  }
}

resource "aws_security_group" "web_tier_sg" {
  name        = "WebTierSG"
  description = "Security group for Web Tier"
  vpc_id      = aws_vpc.havingwebappvpc.id


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
    Name = "WebTierSG"
  }
}

resource "aws_security_group" "internal_lb_sg" {
  name        = "internal-lb-sg"
  description = "Security group for internal load balancer"
  vpc_id      = aws_vpc.havingwebappvpc.id

  ingress {
    description     = "HTTP from WebTierSG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "internal-lb-sg"
  }
}

resource "aws_security_group" "private_instance_sg" {
  name        = "PrivateInstanceSG"
  description = "Security group for private instances"
  vpc_id      = aws_vpc.havingwebappvpc.id

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
    Name = "PrivateInstanceSG"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "DBSG"
  description = "Security group for database"
  vpc_id      = aws_vpc.havingwebappvpc.id

  ingress {
    description     = "MySQL/Aurora from PrivateInstanceSG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_instance_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DBSG"
  }
}


# Create Elastic IPs for NAT Gateways
resource "aws_eip" "nat_2a" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.havingwebappigw]
}

resource "aws_eip" "nat_2b" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.havingwebappigw]
}

# Create NAT Gateways
resource "aws_nat_gateway" "natgw_us_west_2a" {
  allocation_id = aws_eip.nat_2a.id
  subnet_id     = aws_subnet.public_web_subnet_az_us_west_2a.id

  tags = {
    Name = "natgw-us-west-2a"
  }

  depends_on = [aws_internet_gateway.havingwebappigw]
}

resource "aws_nat_gateway" "natgw_us_west_2b" {
  allocation_id = aws_eip.nat_2b.id
  subnet_id     = aws_subnet.public_web_subnet_az_us_west_2b.id

  tags = {
    Name = "natgw-us-west-2b"
  }

  depends_on = [aws_internet_gateway.havingwebappigw]
}

# Create DB subnet group
resource "aws_db_subnet_group" "havingwebappdbsubnetgroup" {
  name       = "havingwebappdbsubnetgroup"
  subnet_ids = [aws_subnet.private_db_subnet_az_us_west_2a.id, aws_subnet.private_db_subnet_az_us_west_2b.id]

  tags = {
    Name = "havingwebappdbsubnetgroup"
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "havingwebapp"
  engine                 = "aurora-mysql"
  engine_mode            = "provisioned"
  engine_version         = "8.0.mysql_aurora.3.05.2" # Use appropriate version
  availability_zones     = ["us-west-2a", "us-west-2b"]
  database_name          = "havingwebappdb"
  master_username        = "admin"
  master_password        = "GBAMZN1234"
  db_subnet_group_name   = aws_db_subnet_group.havingwebappdbsubnetgroup.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "database-1"
  }
}

resource "aws_rds_cluster_instance" "aurora_instance_1" {
  identifier          = "database-1-instance-1"
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = "db.r6g.large"
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false
}

resource "aws_rds_cluster_instance" "aurora_instance_2" {
  identifier          = "database-1-instance-2"
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = "db.r6g.large"
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false
}


#create AppLayer ec2 instance:
#
#resource "aws_instance" "app_layer" {
#  ami           = "ami-0e15ccb98d2e12508"
#  instance_type = "t3.micro"
#  subnet_id     = aws_subnet.private_app_subnet_az_us_west_2a.id
#
#  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
#  iam_instance_profile   = "havingwebappec2role"
#
#  associate_public_ip_address = false
#
#  tags = {
#    Name = "AppLayer"
#  }
#}
#


#create WebLayer ec2 instance:

#resource "aws_instance" "web_layer" {
#  ami           = "ami-028c87ca8a4db0611"
#  instance_type = "t3.micro"
#  subnet_id     = aws_subnet.public_web_subnet_az_us_west_2a.id
#
#  vpc_security_group_ids = [aws_security_group.web_tier_sg.id]
#  iam_instance_profile   = "havingwebappec2role"
#
#  associate_public_ip_address = true
#
#  tags = {
#    Name = "WebLayer"
#  }
#}




#create target groups
resource "aws_lb_target_group" "app_tier_target_group" {
  name        = "app-tier-target-group"
  target_type = "instance"
  protocol    = "HTTP"
  port        = 4000
  vpc_id      = aws_vpc.havingwebappvpc.id

  health_check {
    protocol            = "HTTP"
    path                = "/health"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}


# Create an internal load balancer
resource "aws_lb" "app_tier_internal_lb" {
  name               = "app-tier-internal-lb"
  load_balancer_type = "application"
  internal           = true
  security_groups    = [aws_security_group.internal_lb_sg.id]
  subnets = [
    aws_subnet.private_app_subnet_az_us_west_2a.id,
    aws_subnet.private_app_subnet_az_us_west_2b.id
  ]
}

resource "aws_lb_listener" "app_tier_internal_lb_listener" {
  load_balancer_arn = aws_lb.app_tier_internal_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tier_target_group.arn
  }
}

resource "aws_launch_template" "app_tier_template" {
  name = "AppTierTemplate"

  image_id               = "ami-0ee84e9b9bf0c70e7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
  iam_instance_profile {
    name = "havingwebappec2role"
  }
}

resource "aws_autoscaling_group" "app_tier_asg" {
  name = "AppTierASG"
  launch_template {
    id = aws_launch_template.app_tier_template.id
  }
  vpc_zone_identifier = [
    aws_subnet.private_app_subnet_az_us_west_2a.id,
    aws_subnet.private_app_subnet_az_us_west_2b.id
  ]
  target_group_arns = [
    aws_lb_target_group.app_tier_target_group.arn
  ]
  desired_capacity = 2
  min_size         = 2
  max_size         = 2
}


#Create External Load Balancer and Auto Scaling
#create target groups
resource "aws_lb_target_group" "web_tier_target_group" {
  name        = "web-tier-target-group"
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80
  vpc_id      = aws_vpc.havingwebappvpc.id

  health_check {
    protocol            = "HTTP"
    path                = "/health"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}


# Create an internet facing load balancer
resource "aws_lb" "web_tier_external_lb" {
  name               = "web-tier-external-lb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.internet_facing_lb_sg.id]
  subnets = [
    aws_subnet.public_web_subnet_az_us_west_2a.id,
    aws_subnet.public_web_subnet_az_us_west_2b.id
  ]
}

resource "aws_lb_listener" "web_tier_external_lb_listener" {
  load_balancer_arn = aws_lb.web_tier_external_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tier_target_group.arn
  }
}

resource "aws_launch_template" "web_tier_template" {
  name = "web-tier-template"

  image_id               = "ami-0561d659cfc90ab4b"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_tier_sg.id]
  iam_instance_profile {
    name = "havingwebappec2role"
  }
}

resource "aws_autoscaling_group" "web_tier_asg" {
  name = "web-tier-asg"
  launch_template {
    id = aws_launch_template.web_tier_template.id
  }
  vpc_zone_identifier = [
    aws_subnet.public_web_subnet_az_us_west_2a.id,
    aws_subnet.public_web_subnet_az_us_west_2b.id
  ]
  target_group_arns = [
    aws_lb_target_group.web_tier_target_group.arn
  ]
  desired_capacity = 2
  min_size         = 2
  max_size         = 2
}
