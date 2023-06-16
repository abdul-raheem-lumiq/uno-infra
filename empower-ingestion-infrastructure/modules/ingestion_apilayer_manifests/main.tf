resource "helm_release" "ingestion-apilayer" {
  name       = "empower-foundation-ingestion-apilayer"
  chart      = "${path.module}/charts/empoweringestionapilayer-0.1.0.tgz"
  namespace  = var.ingestion_apilayer_namespace
  create_namespace = true
#     values = [
#     file("${path.module}/charts/values.yaml")
#   ]
  set {
    name  = "deployment.image"
    value = var.deployment_image
  }
  set {
    name  = "deployment.env.port"
    value = var.env_port
  }

  set {
    name  = "deployment.env.host"
    value = var.env_host
  }
  
  set {
    name  = "deployment.env.databasetype"
    value = var.env_databasetype
  }

   set {
    name  = "deployment.env.databasehost"
    value = var.env_databasehost
  }

  set {
    name  = "deployment.env.databaseport"
    value = var.env_databaseport
  }

  set {
    name  = "deployment.env.databaseuser"
    value = var.env_databaseuser
  }

  set {
    name  = "deployment.env.databasepassword"
    value = var.env_databasepassword
  }

  set {
    name  = "deployment.env.databasename"
    value = var.env_databasename
  }

  set {
    name  = "deployment.env.airflowuser"
    value = var.env_airflowuser
  }

  set {
    name  = "deployment.env.airflowpassword"
    value = var.env_airflowpassword
  }

  set {
    name  = "deployment.env.airflowhost"
    value = var.env_airflowhost
  }

  set {
    name  = "deployment.env.airflowport"
    value = var.env_airflowport
  }

  set {
    name  = "deployment.env.awsregion"
    value = var.env_awsregion
  }

  set {
    name  = "deployment.env.awsbucketname"
    value = var.env_awsbucketname
  }

  set {
    name  = "deployment.env.awsbucketnamemount"
    value = var.env_awsbucketnamemount
  }
}
