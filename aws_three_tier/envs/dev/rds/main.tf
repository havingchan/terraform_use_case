provider "aws" {
  region = "us-west-2"
}

module "rds" {
  source             = "../../../modules/rds"
  vpc_name           = "Having-Web-App-VPC"
  subnet1_name       = "Subnet-DB1"
  subnet2_name       = "Subnet-DB2"
  dbsg               = "havingwebappdbsg"
  dbsg_name          = "Having-Web-App-DBSG"
  cluster_identifier = "havingwebappauroracluster"
  engine             = "aurora-mysql"
  engine_version     = "8.0.mysql_aurora.3.05.2"
  engine_mode        = "provisioned"
  az1                = "us-west-2a"
  az2                = "us-west-2b"
  database_name      = "havingwebappdb"
  master_username    = "admin"
  master_password    = "admin123"
  sg_name            = "DB-Instance-SG"
  instance_class     = "db.r6g.large"
  identifier1        = "havingwebappaurorainstance1"
  identifier2        = "havingwebappaurorainstance2"
}