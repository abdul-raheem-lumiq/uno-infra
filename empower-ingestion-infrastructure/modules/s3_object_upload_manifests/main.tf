resource "aws_s3_bucket_object" "object" {
  bucket = var.bucket_name
  key    = var.bucket_key
  source = var.path_to_file
}