# Backend Subnet
resource "aws_subnet" "subnet-backend" {
  cidr_block = var.subnet_backend_range
  vpc_id     = aws_vpc.app-vpc.id
}

resource "aws_route_table" "vpc-route-table" {
  vpc_id = aws_vpc.app-vpc.id

  route {
    cidr_block = var.allowed_ips
    gateway_id = aws_internet_gateway.app-vpc-gw.id
  }

  tags = {
    Name = "subnet-backend-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-backend.id
  route_table_id = aws_route_table.vpc-route-table.id
}



# DB Subnet
# Need 2 private subnets in order to create DB subnet group
resource "aws_subnet" "subnet-database" {
  cidr_block           = var.subnet_database_range
  vpc_id               = aws_vpc.app-vpc.id
  availability_zone_id = "euw1-az1"
}

resource "aws_subnet" "subnet-database-2" {
  cidr_block           = var.subnet_database_range2
  vpc_id               = aws_vpc.app-vpc.id
  availability_zone_id = "euw1-az2"
}

# RDS Instance Subnet group
resource "aws_db_subnet_group" "subnet-group-database" {
  name       = "database-subnet-group"
  subnet_ids = [aws_subnet.subnet-database.id, aws_subnet.subnet-database-2.id]
}