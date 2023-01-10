variable "bucket_name" {
  description = "Name of the S3 bucket. Must be unique. Use domain.name for static website hosting"
  type = string
}

variable "tags" {
  description = "Tags to set on resource, like Environment, SourceUrl, TfstateUrl"
  type = map(string)
  default = {}
}
