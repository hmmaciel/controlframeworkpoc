resource "aws_subnet" "subnet-uno" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.poc-env.id
}

resource "aws_route_table" "route-table-poc-env" {
  vpc_id = aws_vpc.poc-env.id

  route {
    cidr_block = var.allowed_ip
    gateway_id = aws_internet_gateway.poc-env-gw.id
  }

  tags = {
    Name = "poc-env-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-uno.id
  route_table_id = aws_route_table.route-table-poc-env.id
}