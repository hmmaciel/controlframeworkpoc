variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "SpringBootAPI"
}

variable "allowed_ips" {
  description = "Value of the IP allowed for EC2 SSH ingress"
  type        = string
  default     = "0.0.0.0/0"
}

variable "rds_port" {
  description = "Port used by RDS MySQL Database"
  type        = number
  default     = 3306
}

variable "subnet_backend_range" {
  description = "Range of IP adresses in Backend subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_database_range" {
  description = "Range of IP adresses in Database subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_database_range2" {
  description = "Range of IP adresses in Database subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "bucket_name" {
  default = "framework-poc-s3-bucket"
}

variable "rest_api_domain_name" {
  default     = "framework-poc.com"
  description = "Domain name of the API Gateway REST API for self-signed TLS certificate"
  type        = string
}

variable "rest_api_name" {
  default     = "framework-poc-api"
  description = "Name of the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}

variable "get_api_path" {
  default     = "/templates/{email}"
  description = "Path to create in the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}

variable "put_api_path" {
  default     = "/questions/{questionId}"
  description = "Path to create in the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}