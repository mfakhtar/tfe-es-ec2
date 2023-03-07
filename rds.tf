resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "postgres"
  engine_version         = "12.5"
  instance_class         = var.db_instance_type
  username               = var.db_user
  password               = var.db_pass
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.guide-tfe-es-sg-db.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

locals {
  private_subnets = aws_subnet.guide-tfe-es-sub-db.id
}


resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [guide-tfe-es-sub-db-1a,guide-tfe-es-sub-db-1b]

  tags = {
    Name = "My DB subnet group"
  }
}
