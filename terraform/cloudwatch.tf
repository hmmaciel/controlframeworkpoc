resource "aws_cloudwatch_log_group" "api-gateway" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.api.id}/api"
  retention_in_days = 3
  # ... potentially other configuration ...
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "cloudtrail-log-group"
  retention_in_days = 3
  # ... potentially other configuration ...
}