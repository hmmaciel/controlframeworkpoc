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

# VPC Endpoint for S3 Bucket
/*
resource "aws_vpc_endpoint" "s3_vpc_endpoint" {
  vpc_id       = aws_vpc.app-vpc.id
  service_name = "com.amazonaws.eu-west-1.s3"
}

resource "aws_vpc_endpoint_route_table_association" "route_table_association" {
  route_table_id  = aws_route_table.vpc-route-table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_vpc_endpoint.id
}
*/