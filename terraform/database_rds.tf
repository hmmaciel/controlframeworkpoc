/*
resource "aws_db_instance" "poc_db" {
  allocated_storage   = 20
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  multi_az            = false
  name                = "poc_db"
  username            = "springuser"
  password            = "NFFLAMAMEAV"
  publicly_accessible = false
  skip_final_snapshot = true

}
*/