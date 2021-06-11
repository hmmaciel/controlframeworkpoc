resource "aws_inspector_resource_group" "inspector" {
  tags = {
    Name = var.instance_name
  }
}

resource "aws_inspector_assessment_target" "inspector" {
  name               = "assessment target"
  resource_group_arn = aws_inspector_resource_group.inspector.arn
}

resource "aws_inspector_assessment_template" "inspector" {
  name       = "inspector"
  target_arn = aws_inspector_assessment_target.inspector.arn
  duration   = 3600

  # https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html#eu-west-1
  rules_package_arns = [
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-ubA5XvBh",
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-sJBhCr0F",
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-SPzU33xe",
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-SnojL3Z6",
  ]
}