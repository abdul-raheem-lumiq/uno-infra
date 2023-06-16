variable airflow_namespace {
  type        = string
  default     = "ingestion-app"
  description = "Airflow namespace"
}
variable repository_ingestion {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com/pryzm-pg"
  description = "Airflow admin username"
}
variable tag_ingestion {
  type        = string
  default     = "48"
  description = "Airflow admin password"
}
variable airflow_password {
  type        = string
  default     = "admin"
  description = "Airflow admin password"
}
variable service_type {
  type        = string
  default     = "LoadBalancer"
  description = "dags storage class"
}
variable annotations {
  type        = string
  default     = "ReadWriteOnce"
  description = "reade write mode for dags persistent volume"
}
variable trigger {
  type        = string
  default     = "false"
  description = "Dags pvc size"
}
variable pgbouncer {
  type        = string
  default     = "false"
  description = "Host for externalDB"
}
variable postgresql {
  type        = string
  default     = "false"
  description = "port of external postgres db"
}
variable workers {
  type        = string
  default     = "false"
  description = "db for airflow"
}
variable redis {
  type        = string
  default     = "false"
  description = "user for airflow db"
}
variable flower {
  type        = string
  default     = "false"
  description = "Password for airflow db user"
}
variable dags_path {
  type        = string
  default     = "/opt/airflow/dags"
  description = "Password for airflow db user"
}
variable storageClass {
  type        = string
  default     = "efs-sc"
  description = "Password for airflow db user"
}
variable persistence_size {
  type        = string
  default     = "10Gi"
  description = "Password for airflow db user"
}
variable gitsync {
  type        = string
  default     = "false"
  description = "Password for airflow db user"
}
variable db_type_ingestion {
  type        = string
  default     = "postgres"
  description = "Password for airflow db user"
}
variable db_host_ingestion {
  type        = string
  default     = "10.221.42.103"
  description = "Password for airflow db user"
}
variable db_port_ingestion {
  type        = string
  default     = "5432"
  description = "Password for airflow db user"
}
variable db_ingestion {
  type        = string
  default     = "airflow_db_test_pryzm"
  description = "Password for airflow db user"
}
variable db_user_ingestion {
  type        = string
  default     = "postgres"
  description = "Password for airflow db user"
}
variable db_password_ingestion {
  type        = string
  default     = "lumiq123"
  description = "Password for airflow db user"
