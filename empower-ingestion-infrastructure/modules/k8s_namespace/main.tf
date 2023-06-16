resource "kubernetes_namespace" "example" {
  metadata {
    name = var.namespace_name
  }
}