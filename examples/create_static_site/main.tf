module "bucket" {
  # source = "../../"
  source = "git@github.com:duleorlovic/tf_aws_s3_buckets.git"
  # when you use domain name, bucket_name must be the same as domain name
  bucket_name = "my-site-2022-08-18"
  tags = {
    SourceUrl = "https://github.com/duleorlovic/tf_aws_s3_buckets"
    TfstateUrl = "@air:terraform_modules/tf_aws_s3_buckets/examples/create_static_site/terraform.tfstate"
  }
}

output "bucket_website_endpoint" {
  value = module.bucket.bucket_website_endpoint
}

output "bucket_name" {
  value = module.bucket.bucket_name
}
