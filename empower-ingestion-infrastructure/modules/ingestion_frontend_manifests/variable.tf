variable ingestion_frontend_namespace {
  type        = string
  default     = "ingestion-app"
  description = "Airflow namespace"
}

variable deployment_image {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com/empower-foundation-ingestion-automation:4"
  description = "deployment image"
}

variable env_viteapiurl {
  type        = string
  default     = "my-secret-api-key-devel"
  description = "env viteapiurl"
}

variable env_vitebaseurl {
  type        = string
  default     = "http://afdc28bdbdf16407788e4764f29d8447-7e1621d8a5ccec79.elb.ap-south-1.amazonaws.com"
  description = "env vitebaseurl"
}

variable env_viteconnectionurl {
  type        = string
  default     = "http://a76c539a7ae144ce695dd6bf0d9a584a-b737aa7236751511.elb.ap-south-1.amazonaws.com"
  description = "env viteconnectionurl"
}

variable virtualService_uriPrefix {
  type        = string
  default     = "/"
  description = "env virtualService uriPrefix"
}

variable virtualService_uriPrefixWithoutSlash {
  type        = string
  default     = "/"
  description = "env virtualService uriPrefixWithoutSlash"
}
