resource "aws_instance" "api_server" {
  ami = "ami-063d4ab14480ac177"
  // Comment following line if using Elastic IP (found in network.tf file)
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "EC2Keypair"
  security_groups             = [aws_security_group.subnet-backend-sg.id]

  tags = {
    Name = var.instance_name
  }

  subnet_id = aws_subnet.subnet-backend.id
}