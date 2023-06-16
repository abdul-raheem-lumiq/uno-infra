variable "cidr_block" {
  default = "10.240.0.0/16"
}
variable "enable_dns_hostnames" {
    default = true
}
variable "enable_dns_support" {
    default = true
}
variable "name" {
  default = "empower-ingestion-vpc"
}
variable "tags" {
  default = {}
}
