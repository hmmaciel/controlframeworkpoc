# Backend Security Group
resource "aws_security_group" "subnet-backend-sg" {
  name   = "ec2-sg"
  vpc_id = aws_vpc.app-vpc.id

  # Allow RDS Database communication
  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    description = "MySQL"
    cidr_blocks = [var.subnet_database_range]
  }

  # Allow SSH traffic from any source
  ingress {
    cidr_blocks = [
      var.allowed_ips
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  # Allow Tomcat port communication
  ingress {
    cidr_blocks = [
      var.allowed_ips
    ]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    description = "HTTP"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Database Security Group
resource "aws_security_group" "subnet-database-sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.app-vpc.id

  # Only MySQL in
  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    description = "MySQL"
    cidr_blocks = [var.subnet_backend_range]
  }

  # Allow all outbound traffic
  egress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    description = "MySQL"
    cidr_blocks = [var.subnet_backend_range]
  }
}