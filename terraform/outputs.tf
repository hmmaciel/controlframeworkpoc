output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.api_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.api_server.public_ip
}

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.poc_db.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.poc_db.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.poc_db.username
  sensitive   = true
}

output "website_domain" {
  value = aws_s3_bucket.react_bucket.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket.react_bucket.website_endpoint
}
