# Creating a Cloud Distribution of the content
locals {
	s3_origin_id = "S3-${aws_s3_bucket.tfbucket.bucket}"
}
resource "aws_cloudfront_distribution" "tfdistribution" {
	origin {
		domain_name = aws_s3_bucket.tfbucket.bucket_domain_name
		origin_id   = local.s3_origin_id
	}
	enabled         = true
	is_ipv6_enabled = true
	default_cache_behavior {
		allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
		cached_methods   = ["GET", "HEAD"]
		target_origin_id = local.s3_origin_id
		forwarded_values {
			query_string = false
			cookies {
				forward = "none"
			}
		}
		viewer_protocol_policy = "allow-all"
		min_ttl                = 0
		default_ttl            = 120
		max_ttl                = 3600
	}
	restrictions {
		geo_restriction {
		restriction_type = "none"
		}
	}
	viewer_certificate {
		cloudfront_default_certificate = true
	}
	depends_on = [
		aws_s3_bucket_object.tfobject
	]
}