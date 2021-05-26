resource "aws_api_gateway_domain_name" "api" {
  domain_name              = aws_acm_certificate.api.domain_name
  regional_certificate_arn = aws_acm_certificate.api.arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "api" {
  api_id      = aws_api_gateway_rest_api.api.id
  domain_name = aws_api_gateway_domain_name.api.domain_name
  stage_name  = aws_api_gateway_stage.api.stage_name
}

resource "aws_api_gateway_rest_api" "api" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.rest_api_name
      version = "1.0"
    }
    paths = {
      (var.get_api_path) = {
        get = {
          "parameters" : [
            {
              "name" : "email",
              "in" : "path",
              "required" : true,
              "schema" : {
                "type" : "string"
              }
            }
          ],
          "security" : [
            {
              "api_key" : []
            }
          ],
          x-amazon-apigateway-integration = {
            "uri" : "http://${aws_instance.api_server.public_ip}:8080/templates/{email}",
            "httpMethod" : "GET",
            "responses" : {
              "default" : {
                "statusCode" : "200"
              }
            },
            "requestParameters" : {
              "integration.request.path.email" : "method.request.path.email"
            },
            "passthroughBehavior" : "when_no_match",
            "type" : "http_proxy"
          }
        }
      }
      (var.put_api_path) = {
        put = {
          "parameters" : [
            {
              "name" : "questionId",
              "in" : "path",
              "required" : true,
              "schema" : {
                "type" : "number"
              }
            }
          ],
          "security" : [
            {
              "api_key" : []
            }
          ],
          x-amazon-apigateway-integration = {
            uri = "http://${aws_instance.api_server.public_ip}:8080/questions/{questionId}"
            "httpMethod" : "PUT",
            "responses" : {
              "default" : {
                "statusCode" : "204"
              }
            },
            "requestParameters" : {
              "integration.request.path.questionId" : "method.request.path.questionId"
            },
            "passthroughBehavior" : "when_no_match",
            "type" : "http_proxy"
          }
        }
      }
    },
    "components" : {
      "securitySchemes" : {
        "api_key" : {
          "type" : "apiKey",
          "name" : "x-api-key",
          "in" : "header"
        }
      }
    }
  })

  name = var.rest_api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api" {
  deployment_id = aws_api_gateway_deployment.api.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "api"
}

resource "aws_api_gateway_method_settings" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.api.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
  }
}

#
# Self-Signed TLS Certificate for Testing
#

resource "tls_private_key" "api" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "api" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  dns_names             = [var.rest_api_domain_name]
  key_algorithm         = tls_private_key.api.algorithm
  private_key_pem       = tls_private_key.api.private_key_pem
  validity_period_hours = 12

  subject {
    common_name  = var.rest_api_domain_name
    organization = "ACME apis, Inc"
  }
}

resource "aws_acm_certificate" "api" {
  certificate_body = tls_self_signed_cert.api.cert_pem
  private_key      = tls_private_key.api.private_key_pem
}

resource "aws_api_gateway_usage_plan" "cloudfront_usage_plan" {
  name = "cloudfront_usage_plan"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.api.stage_name
  }
}

resource "aws_api_gateway_api_key" "cloudfront_api_key" {
  name = "api_key"
}

resource "aws_api_gateway_usage_plan_key" "cloudfront_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.cloudfront_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.cloudfront_usage_plan.id
}