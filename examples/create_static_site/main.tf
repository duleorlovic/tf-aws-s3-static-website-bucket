module "bucket" {
  source = "../../"
  bucket_name = "my-site-2022-08-18"
  tags = {
    SourcePath = "@air:terraform_modules/tf-aws-s3-static-website-bucket/examples/create_static_site"
  }
}

output "bucket_website_endpoint" {
  value = module.bucket.bucket_website_endpoint
}

output "bucket_name" {
  value = module.bucket.bucket_name
}
