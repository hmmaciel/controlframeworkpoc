/*
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
*/

# Get current user ID logged into AWS CLI
// data "aws_canonical_user_id" "current_user" {}

resource "aws_s3_bucket" "react_bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  # Encrypts S3 bucket data with provided KMS key - Maybe useful for logs?
  /*
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  */
}

resource "aws_s3_bucket_policy" "react_bucket" {
  bucket = aws_s3_bucket.react_bucket.id
  policy = data.aws_iam_policy_document.s3_iam_doc.json
}

resource "aws_s3_bucket_public_access_block" "react_bucket" {
  bucket = aws_s3_bucket.react_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_metric" "react_bucket" {
  bucket = aws_s3_bucket.react_bucket.bucket
  name   = "EntireBucket"
}
