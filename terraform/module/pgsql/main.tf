

# Create a security group for the Aurora cluster
resource "aws_security_group" "aurora_sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

# Create an Aurora cluster
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "my-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "11.9"
  database_name           = "my_database"
  master_username         = "admin"
  master_password         = "password"
  backup_retention_period = 7
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
}

# Create a subnet group for the Aurora cluster
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}