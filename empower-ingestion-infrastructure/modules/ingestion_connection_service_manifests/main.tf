resource "helm_release" "ingestion-connection-service" {
  name       = "empower-foundation-ingestion-connection-service"
  chart      = "${path.module}/charts/empoweringestionconnection-0.1.1.tgz"
  namespace  = var.ingestion_connection_service_namespace
  create_namespace = true
  set {
    name  = "deployment.image"
    value = var.deployment_image
  }
  set {
    name  = "env.port"
    value = var.env_port
  }

  set {
    name  = "env.host"
    value = var.env_host
  }
}
