resource "tls_private_key" "webserver_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "local_file" "private_key" {
  content         = tls_private_key.webserver_private_key.private_key_pem
  filename        = "EC2Keypair.pem"
  file_permission = 0400
}
resource "aws_key_pair" "webserver_key" {
  key_name   = "EC2Keypair"
  public_key = tls_private_key.webserver_private_key.public_key_openssh
}