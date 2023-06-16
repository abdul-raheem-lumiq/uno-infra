resource "helm_release" "ingestion-frontend" {
  name       = "empower-foundation-ingestion-frontend"
  chart      = "${path.module}/charts/empoweringestionfrontend-0.1.0.tgz"
  namespace  = var.ingestion_frontend_namespace
  create_namespace = true
#     values = [
#     file("${path.module}/charts/values.yaml")
#   ]
  set {
    name  = "deployment.image"
    value = var.deployment_image
  }
  set {
  name  = "deployment.env.viteapiurl"
  value = var.env_viteapiurl
  }

  set {
    name  = "deployment.env.vitebaseurl"
    value = var.env_vitebaseurl
  }
  
  set {
    name  = "deployment.env.viteconnectionurl"
    value = var.env_viteconnectionurl
  }

  set {
    name  = "virtualService.uriPrefix"
    value = var.virtualService_uriPrefix
  }

  set {
    name  = "virtualService.uriPrefixWithoutSlash"
    value = var.virtualService_uriPrefixWithoutSlash
  }

}
