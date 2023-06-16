variable ingestion_apilayer_namespace {
  type        = string
  default     = "ingestion-app"
  description = "apilayer namespace"
}
variable deployment_image {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com/empower-foundation-ingestion-automation:7"
  description = "deployment image"
}

variable env_port {
  default     = "6100"
  description = "container port number"
}

variable env_host {
  default     = "0.0.0.0"
  description = "env host name"
}

variable env_databasetype {
  type        = string
  default     = "postgres"
  description = "database type"
}

variable env_databasehost {
  type        = string
  default     = "pryzm-db.cepsv5f9ayrr.ap-south-1.r"
  description = "database host"
}

variable env_databaseport {
  #type        = string
  default     = "25432"
  description = "database port"
}

variable env_databaseuser {
  type        = string
  default     = "postgres"
  description = "database user"
}

variable env_databasepassword {
  type        = string
  default     = "lumiq123"
  description = "database password"
}

variable env_databasename {
  type        = string
  default     = "empower_foundation_app_db"
  description = "database name"
}

variable env_airflowuser {
  type        = string
  default     = "admin"
  description = "airflow user"
}

variable env_airflowpassword {
  type        = string
  default     = "admin"
  description = "airflow password"
}

variable env_airflowhost {
  type        = string
  default     = "airflow-web.sidecar.svc.cluster.local"
  description = "airflow host"
}

variable env_airflowport {
  default     = "80"
  description = "airflow port"
}

variable env_awsregion {
  type        = string
  default     = "ap-south-1"
  description = "aws region"
}

variable env_awsbucketname {
  type        = string
  default     = "empower-foundation-artifact-bucket"
  description = "aws bucket name"
}

variable env_awsbucketnamemount {
  type        = string
  default     = "empower-s3-mount"
  description = "aws bucket name mount"
}

