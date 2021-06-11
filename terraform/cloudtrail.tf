data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "cloudtrail" {
  name           = "cloudtrail"
  s3_bucket_name = aws_s3_bucket.cloudtrail-bucket.id
  s3_key_prefix  = "CloudTrailLogs"
  # include_global_service_events = false
  kms_key_id = aws_kms_key.log_bucket_key.arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type = "AWS::S3::Object"

      # Make sure to append a trailing '/' to your ARN if you want
      # to monitor all objects in a bucket.
      values = ["${aws_s3_bucket.react_bucket.arn}/"]
    }
  }

  # cloud_watch_logs_role_arn = 
  # cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
}

resource "aws_s3_bucket" "cloudtrail-bucket" {
  bucket        = "framework-poc-cloudtrail-logs-s3"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::framework-poc-cloudtrail-logs-s3"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::framework-poc-cloudtrail-logs-s3/CloudTrailLogs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

/*
resource "aws_kms_key" "cloudtrail-key" {
  description             = "This key is used to encrypt Cloudtrail's logs"
  deletion_window_in_days = 10
}
*/