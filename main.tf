# https://learn.hashicorp.com/tutorials/terraform/module-create?in=terraform/modules
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteEndpoints.html
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteAccessPermissionsReqd.html#bucket-policy-static-site
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/website-hosting-custom-domain-walkthrough.html#root-domain-walkthrough-create-buckets

# We need bucket, website_configuration and policy

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags = var.tags
}

# I think this is not needed
# resource "aws_s3_bucket_acl" "bucket_acl" {
#   bucket = aws_s3_bucket.bucket.id
#   acl    = "public-read"
# }

resource "aws_s3_bucket_website_configuration" "bucket_configuration" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = "${aws_s3_bucket.bucket.arn}/*"
      },
    ]
  })
}

# You can upload the file using terraform instead of cli
# resource "aws_s3_object" "webapp" {
#   acl          = "public-read"
#   key          = "index.html"
#   bucket       = aws_s3_bucket.bucket.id
#   content      = file("${path.module}/www/index.html")
#   content_type = "text/html"
# }
