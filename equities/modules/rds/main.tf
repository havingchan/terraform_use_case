resource "aws_db_subnet_group" "dbsg" {
  name       = var.dbsg
  subnet_ids = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]
  tags = {
    Name = var.dbsg_name
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = var.cluster_identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  engine_mode            = var.engine_mode
  availability_zones     = [var.az1, var.az2]
  database_name          = var.database_name
  master_username        = var.master_username
  master_password        = var.master_password
  db_subnet_group_name   = aws_db_subnet_group.dbsg.name
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  skip_final_snapshot    = true
  tags = {
    Name = var.cluster_identifier
  }

}

resource "aws_rds_cluster_instance" "aurora_instance_1" {
  identifier          = var.identifier1
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false
}

resource "aws_rds_cluster_instance" "aurora_instance_2" {
  identifier          = var.identifier2
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false

}