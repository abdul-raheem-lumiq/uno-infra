resource "helm_release" "keycloak" {
  name       = "keycloak"
  chart      = "${path.module}/charts/keycloak-15.1.2.tgz"
  namespace  = var.keycloak_namespace
  create_namespace = true
#     values = [
#     file("${path.module}/charts/values.yaml")
#   ]
    set {
        name = "image.registry"
        value = var.image_registry
    }
    set {
        name = "image.repository"
        value = var.image_repository
    }
    set {
        name = "image.tag"
        value = var.image_tag
    }
    set {
        name = "auth.adminUser"
        value = var.adminUser
    }
    set {
        name = "auth.adminPassword"
        value = var.adminPassword
    }
    set {
        name = "tls.enabled"
        value = var.tls_enabled
    }
    set {
        name = "tls.autoGenerated"
        value = var.tls_autoGenerated
    }
    set {
        name = "production"
        value = var.production
    }
    set {
        name = "httpRelativePath"
        value = var.httpRelativePath
    }
    set {
        name = "service.type"
        value = var.service_type
    }
    set {
        name = "postgresql.enabled"
        value = false
    }
    set {
        name = "externalDatabase.host"
        value = var.externalDatabase_host
    }
    set {
        name = "externalDatabase.port"
        value = var.externalDatabase_port
    }
    set {
        name = "externalDatabase.user"
        value = var.externalDatabase_user
    }
    set {
        name = "externalDatabase.database"
        value = var.externalDatabase_database
    }
    set {
        name = "externalDatabase.password"
        value = var.externalDatabase_password
    }
}