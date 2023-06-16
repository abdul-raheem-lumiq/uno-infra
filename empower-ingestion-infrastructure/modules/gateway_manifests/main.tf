resource "helm_release" "gateway" {
  name       = "empower-foundation-ingestion-gateway"
  chart      = "${path.module}/charts/empower-ingestion-gateway-0.1.1.tgz"
  namespace  = var.ingestion_gateway_namespace
  create_namespace = true
#     values = [
#     file("${path.module}/charts/values.yaml")
#   ]
}
