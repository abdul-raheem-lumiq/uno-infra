resource "null_resource" "db_1" {
    # depends_on = [
    #     module.rds_instance
    # ]
    provisioner "local-exec" {
    command     = "postgres_db_create.sh"
    interpreter = ["/bin/bash"]
    working_dir = path.module

    environment = {
      IDENTIFIER = var.identifier
      PASSWORD = var.password
      DBNAME = var.db_name
    }
  }
}
