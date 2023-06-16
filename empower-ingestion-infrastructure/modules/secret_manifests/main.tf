resource "helm_release" "secret_manifests" {
  name       = "empower-foundation-ingestion-gateway-secret"
  chart      = "${path.module}/charts/empower-ingestion-gateway-secret-0.1.0.tgz"
#     values = [
#     file("${path.module}/charts/values.yaml")
#   ]
  set {
    name  = "secret.cert"
    value = var.secret_cert
  }
  set {
  name  = "secret.key"
  value = var.secret_key
  }
}
