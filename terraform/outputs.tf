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
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.poc_db.port
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.poc_db.username
}

output "website_domain" {
  value = aws_s3_bucket.react_bucket.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket.react_bucket.website_endpoint
}

output "api_gateway_url" {
  depends_on = [aws_api_gateway_base_path_mapping.api]

  description = "API Gateway Domain URL (self-signed certificate)"
  value       = "https://${aws_api_gateway_domain_name.api.regional_domain_name}"
}

output "curl_stage_invoke_url" {
  description = "API Gateway Stage Invoke URL"
  value       = aws_api_gateway_stage.api.invoke_url
}
