# Terraform AWS S3 static website bucket

This is a module which you can use to create a bucket.
```
cd examples/create_static_site
terraform init
terraform apply --auto-approve
```
and use AWS CLI to upload html files from www folder

```
aws s3 cp www s3://$(terraform output -raw bucket_name) --recursive

aws s3 ls s3://$(terraform output -raw bucket_name) --recursive
```
open the site
```
open $(terraform output -raw bucket_website_endpoint)
```

Nested folders works fine, so you can visit `/a/b` or `/a/b/index.html`.
Three domains:
* using subpath `s3.amazonaws.com/#{bucket-name}`
* using subdomain `#{bucket-name}.s3.amazonaws.com`
* using subdomain and region `#{bucket-name}.s3-website-us-east-1.amazonaws.com`
```
curl http://s3.amazonaws.com/$(terraform output -raw bucket_name)/a/b/index.html
curl http://$(terraform output -raw bucket_name).s3.amazonaws.com/a/b/index.html
curl http://$(terraform output -raw bucket_name).s3-website-us-east-1.amazonaws.com/a/b/index.html
```

# Https

Https works if you do not have dot in the bucket name and accessing using
subdomain or subpath format ONLY (using s3-website-us-east-1 does not work) and
with exact path to file.
Note that redirection `/a/b/`->`/a/b/index.html` does not work when using https.

```
# redirection does not work
curl https://$(terraform output -raw bucket_name).s3.amazonaws.com/
# but direct file access works
curl https://$(terraform output -raw bucket_name).s3.amazonaws.com/index.html
curl https://s3.amazonaws.com/$(terraform output -raw bucket_name)/a/b/index.html
curl https://$(terraform output -raw bucket_name).s3.amazonaws.com/a/b/index.html
```

# Custom domain

TODO: custom domains with https

# Remove

To remove the site you should remove all S3 files first (you do not need to
remove files that you added with `aws_s3_object`):
```
aws s3 rm s3://$(terraform output -raw bucket_name)/ --recursive
```
and remove bucket
```
terraform destroy --auto-approve
```
