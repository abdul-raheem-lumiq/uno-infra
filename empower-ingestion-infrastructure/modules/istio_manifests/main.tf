# resource "kubernetes_namespace" "istio_system" {
#   metadata {
#     # annotations = {
#     #   name = "example-annotation"
#     # }
#     # labels = {
#     #   mylabel = "label-value"
#     # }
#     name = "istio-system"
#   }
# }

# resource "kubernetes_namespace" "drishti" {
#   metadata {
#     # annotations = {
#     #   name = "example-annotation"
#     # }
#     labels = {
#       istio-injection = "enabled"
#     }
#     name = "drishti"
#   }
# }

locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
}

resource "helm_release" "istio_base" {
  repository       = local.istio_charts_url
  chart            = "base"
  name             = "istio-base"
  namespace        = var.namespace
  version          = var.istio_version
  create_namespace = true
}

resource "helm_release" "istiod" {
  repository       = local.istio_charts_url
  chart            = "istiod"
  name             = "istiod"
  namespace        = var.namespace
  create_namespace = true
  version          = var.istio_version
  depends_on       = [helm_release.istio_base]
}

resource "helm_release" "istio-ingress" {
  repository = local.istio_charts_url
  chart      = "gateway"
  name       = "istio-ingress"
  namespace  = var.namespace
  version    = var.istio_version
  depends_on = [helm_release.istiod]

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}