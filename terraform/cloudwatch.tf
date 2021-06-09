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

# CloudWatch Alarms

resource "aws_cloudwatch_metric_alarm" "api_gateway_alarm" {
  alarm_name                = "api-forbidden-reqs-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "4XXError"
  namespace                 = "AWS/ApiGateway"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "3"
  alarm_description         = "This metric monitors failed requests to the API Gateway"
  insufficient_data_actions = []

  dimensions = {
    ApiName = var.rest_api_name
    Stage   = "api"
  }
}