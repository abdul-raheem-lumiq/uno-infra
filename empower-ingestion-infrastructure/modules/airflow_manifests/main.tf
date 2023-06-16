resource "helm_release" "airflow" {
  name       = "airflow"
  chart      = "${path.module}/charts/airflow-8.6.1.tgz"
  namespace  = var.airflow_namespace
  values = [
    file("${path.module}/gitsync-schedular-overwrite.yaml")
  ]
  create_namespace = true
  set {
    name  = "airflow.image.repository"
    value = var.repository_ingestion
}

set {
    name  = "airflow.image.tag"
    value = var.tag_ingestion
}

#set {
#    name  = "airflow.users.password"
#    value = var.airflow_password
#}

set {
    name  = "web.services.type"
    value = var.service_type
}

#set {
#    name  = "web.service.annotations"
#    value = var.annotations
#}

set {
    name  = "trigger.enabled"
    value = var.trigger
}

set {
    name  = "pgbouncer.enabled"
    value = var.pgbouncer
}

set {
    name  = "postgresql.enabled"
    value = var.postgresql
}

set {
    name  = "workers.enabled"
    value = var.workers
}

set {
    name  = "redis.enabled"
    value = var.redis
}

set {
    name  = "flower.enabled"
    value = var.flower
}


set {
    name  = "dags.path"
    value = var.dags_path
}

set {
    name  = "dags.persistence.storageClass"
    value = var.storageClass
}

set {
    name  = "dags.persistence.size"
    value = var.persistence_size
}

set {
    name  = "dags.gitSync.enabled"
    value = var.gitsync
}

set {
    name  = "externalDatabase.type"
    value = var.db_type_ingestion
}

set {
    name  = "externalDatabase.host"
    value = var.db_host_ingestion
}

set {
    name  = "externalDatabase.port"
    value = var.db_port_ingestion
}

set {
    name  = "externalDatabase.database"
    value = var.db_ingestion
}

set {
    name  = "externalDatabase.user"
    value = var.db_user_ingestion
}

set {
    name  = "externalDatabase.password"
    value = var.db_password_ingestion
}
