resource "aws_vpc" "app-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "app-vpc"
  }
}

// Uncomment if you want an Elastic IP
/*
resource "aws_eip" "ip-app-vpc" {
  instance = aws_instance.api_server.id
  vpc      = true
}
*/