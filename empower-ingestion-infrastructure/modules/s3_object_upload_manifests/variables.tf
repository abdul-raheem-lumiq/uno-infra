variable "bucket_name" {
  type = string
  default = "your_bucket_name"
  description = "bucket name"
}
variable "bucket_key" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}

