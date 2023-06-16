variable istio_version {
  type        = string
  default     = "1.14"
  description = "istio version"
}
variable namespace {
  type        = string
  default     = "istio-system"
  description = "istio namespace"
}