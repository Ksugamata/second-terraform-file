resource "aws_cloudfront_origin_access_control" "lp_oac" {
  name                              = "lp-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
  description                       = "OAC for LP"
}

resource "aws_cloudfront_distribution" "lp_distribution" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.lp_bucket.bucket_regional_domain_name
    origin_id   = "lpS3Origin"

    origin_access_control_id = aws_cloudfront_origin_access_control.lp_oac.id
  }

  default_cache_behavior {
    target_origin_id       = "lpS3Origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_cert_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = [var.domain_name]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "LP CloudFront"
  }
}