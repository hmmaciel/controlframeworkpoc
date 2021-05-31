resource "aws_db_instance" "poc_db" {
  allocated_storage               = 10
  engine                          = "mysql"
  instance_class                  = "db.t2.micro"
  multi_az                        = false
  name                            = "poc_db"
  username                        = "springuser"
  password                        = "NFFLAMAMEAV"
  publicly_accessible             = false
  skip_final_snapshot             = true
  vpc_security_group_ids          = [aws_security_group.subnet-database-sg.id]
  db_subnet_group_name            = aws_db_subnet_group.subnet-group-database.name
  enabled_cloudwatch_logs_exports = ["error", "slowquery"]
}