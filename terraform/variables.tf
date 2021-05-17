variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "allowed_ip" {
  description = "Value of the IP allowed for EC2 SSH ingress"
  type        = string
  default     = "0.0.0.0/0"
}