resource "helm_release" "ingress_manifests" {
  name       = "empower-foundation-ingestion-ingress"
  chart      = "${path.module}/charts/empower-ingestion-ingress-0.1.0.tgz"
  namespace  = var.ingress_manifests_namespace
  create_namespace = true
#     values = [
#     file("${path.module}/charts/values.yaml")
#   ]
  set {
    name  = "certificate_arn"
    value = var.certificate_arn
  }
  set {
    name  = "backendservice"
    value = var.backend_service
  }
  # set {
  #   name  = "subnets"
  #   value = var.subnets
  # }

  set {
    name  = "alb_name"
    value = var.alb_name
  }
}

resource "time_sleep" "wait_300_seconds" {
  depends_on = [resource.helm_release.ingress_manifests]

  create_duration = "300s"
}