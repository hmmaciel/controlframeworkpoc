resource "aws_internet_gateway" "app-vpc-gw" {
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name = "app-vpc-gw"
  }
}