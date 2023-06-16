resource "null_resource" "add_kubeconfig" {
    # depends_on = [
    #     module.rds_instance
    # ]
    provisioner "local-exec" {
    command     = "add_kubeconfig.sh"
    interpreter = ["/bin/bash"]
    working_dir = path.module

    environment = {
      CLUSTER_NAME = var.cluster_name
      REGION_CODE = var.region
    }
  }
}
