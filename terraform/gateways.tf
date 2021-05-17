resource "aws_internet_gateway" "poc-env-gw" {
  vpc_id = aws_vpc.poc-env.id

  tags = {
    Name = "poc-env-gw"
  }
}