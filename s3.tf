resource "aws_s3_bucket" "lp_bucket" {
  bucket        = "lp-${var.domain_name}"
  force_destroy = true

  tags = {
    Name = "LP Hosting Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "lp_bucket_block" {
  bucket = aws_s3_bucket.lp_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "lp_bucket_policy" {
  bucket = aws_s3_bucket.lp_bucket.id

  depends_on = [
    aws_s3_bucket_public_access_block.lp_bucket_block
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.lp_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "lp_website" {
  bucket = aws_s3_bucket.lp_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}
