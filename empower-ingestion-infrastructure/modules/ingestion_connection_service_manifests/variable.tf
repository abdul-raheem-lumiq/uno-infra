variable ingestion_connection_service_namespace {
  type        = string
  default     = "ingestion-app"
  description = "ingestion connection service namespace"
}

variable deployment_image {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com/empower-foundation-ingestion-automation:3"
  description = "deployment image"
}

variable env_port {
  default     = "6200"
  description = "env port"
}

variable env_host {
  default     = "0.0.0.0"
  description = "env host"
}