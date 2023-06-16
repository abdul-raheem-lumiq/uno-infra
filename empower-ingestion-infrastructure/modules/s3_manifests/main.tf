resource "aws_s3_bucket" "S3Bucket" {
  bucket = var.bucket_name

  tags = {
    Project = "empower-foundation-ingestion"
  }
}