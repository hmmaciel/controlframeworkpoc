resource "aws_securityhub_account" "securityhub" {}

resource "aws_securityhub_standards_subscription" "cis" {
  depends_on    = [aws_securityhub_account.securityhub]
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
}

data "aws_region" "current" {}

resource "aws_securityhub_product_subscription" "guardduty_findings" {
  depends_on  = [aws_securityhub_account.securityhub]
  product_arn = "arn:aws:securityhub:${data.aws_region.current.name}::product/aws/guardduty"
}

resource "aws_securityhub_product_subscription" "inspector_findings" {
  depends_on  = [aws_securityhub_account.securityhub]
  product_arn = "arn:aws:securityhub:${data.aws_region.current.name}::product/aws/inspector"
}