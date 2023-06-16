module "rds_instance" {
    source = "../modules/rds_manifests"
    identifier = var.identifier
    username = var.username
    password = var.password
    vpc_id = var.vpc_id
    db_subnet_ids = var.db_subnet_ids
    db_subnet_group_name = var.db_subnet_group_name
    sg_name = var.sg_name
}
module "s3_bucket_1" {
    source = "../modules/s3_manifests"
    bucket_name = var.bucket_name_1
}
module "s3_bucket_2" {
    source = "../modules/s3_manifests"
    bucket_name = var.bucket_name_2
}
module "s3_bucket_3" {
    source = "../modules/s3_manifests"
    bucket_name = var.bucket_name_3
}
#module "s3_bucket_4" {
#    source = "../modules/s3_manifests"
#    bucket_name = var.bucket_name_4
#}
module "db_1" {
    depends_on = [
      module.rds_instance
    ]
    source = "../modules/db_create_null"
    identifier = var.identifier
    password = var.password
    db_name = var.db_name_1
}
module "db_2" {
    depends_on = [
      module.rds_instance, 
      module.db_1
    ]
    source = "../modules/db_create_null"
    identifier = var.identifier
    password = var.password
    db_name = var.db_name_2
}
module "db_3" {
    depends_on = [
      module.rds_instance, 
      module.db_2
    ]
    source = "../modules/db_create_null"
    identifier = var.identifier
    password = var.password
    db_name = var.db_name_3
}
module "db_4" {
    depends_on = [
      module.rds_instance, 
      module.db_3
    ]
    source = "../modules/db_create_null"
    identifier = var.identifier
    password = var.password
    db_name = var.db_name_4
}
module "eks_cluster" {
    # depends_on = [
    #   module.rds_instance
    # ]
    source                      = "../modules/eks_manifests"
    aws_vpc                     = var.aws_vpc
    eks-name-sg                 = var.eks-name-sg
    nodes_sg_name-eks-nodes     = var.nodes_sg_name-eks-nodes
    eks-name                    = var.eks-name
    privatesubnet1              = var.privatesubnet1
    privatesubnet2              = var.privatesubnet2
    # endpoint_public_access    = var.endpoint_public_access
    # endpoint_private_access   = var.endpoint_private_access
    ng-name                     = var.ng-name
    # ami_type                  = var.ami_type
    disk_size                   = var.disk_size
    instance_types              = var.instance_types
    version-cluster             = var.version-cluster
    pvt_desired_size            = var.pvt_desired_size
    pvt_min_size                = var.pvt_min_size
    pvt_max_size                = var.pvt_max_size
    # logtypes                  = var.logtypes
    eks_iam_role                = var.eks_iam_role
    # kube_proxy_version        = var.kube_proxy_version
    # vpc_cni_version           = var.vpc_cni_version
}
module "add_kubeconfig" {
    depends_on = [
      module.eks_cluster
    ]
    source                      = "../modules/add_kube_config_manifests"
    cluster_name                = var.eks-name
    region                      = var.region
}
module "istio" {
    depends_on = [
      module.add_kubeconfig
    ]
    source                      = "../modules/istio_manifests"
    istio_version               = var.istio_version
    namespace                   = var.istio_namespace_name
}
module "secret_manifests" {
    depends_on = [
      module.add_kubeconfig,
      module.istio
    ]
    source = "../modules/secret_manifests"
}
module "gateway" {
    depends_on = [
      module.add_kubeconfig,
      module.secret_manifests,
      module.ingestion_backend,
      module.ingestion_connection_service,
      module.ingestion_frontend
    ]
    source = "../modules/gateway_manifests"
    ingestion_gateway_namespace = var.namespace_name
}
module "ingress_manifests" {
  depends_on = [
      module.add_kubeconfig,
      module.alb_controller
    ]
    source = "../modules/ingress_manifests"
    alb_name = var.alb_name
    certificate_arn = var.alb_certificate_arn
    ingress_manifests_namespace = var.ingress_manifests_namespace
    backend_service = var.ingress_backend_service
    subnets = var.alb_subnets
}
module "ingestion_backend" {
    depends_on = [
      module.add_kubeconfig
    ]
    source = "../modules/ingestion_backend_manifests"
    ingestion_backend_namespace = var.namespace_name
    deployment_image = var.ingestion_bk_deployment_image
    # env_port = var.ingestion_bk_env_port
    # env_host = var.ingestion_bk_env_host
    # env_databasetype = var.ingestion_bk_env_databasetype
    env_databasehost = module.rds_instance.address
    env_databaseport = module.rds_instance.port
    #env_databaseport = "1111"
    env_databaseuser = module.rds_instance.username
    env_databasepassword = var.password
    env_databasename = var.db_name_1
    env_airflowuser = var.airflow_user_name
    env_airflowpassword = var.airflow_password
    env_airflowhost = var.env_airflowhost
    env_airflowport = var.env_airflowport
    env_awsregion = var.region
    env_awsbucketname = var.bucket_name_3
    env_awsbucketnamemount = var.bucket_name_4
}
module "ingestion_frontend" {
    depends_on = [
      module.add_kubeconfig,
      module.ingress_manifests
    ]
    source                      = "../modules/ingestion_frontend_manifests"
    ingestion_frontend_namespace = var.namespace_name
    deployment_image = var.frontend_deployment_image
    env_viteapiurl = var.frontend_env_viteapiurl
    env_vitebaseurl = "https://${module.ingress_manifests.alb_name}/ingestionbackend"
    env_viteconnectionurl = "https://${module.ingress_manifests.alb_name}/ingestionconnectionservice"

}
module "ingestion_connection_service" {
    depends_on = [
      module.add_kubeconfig
    ]
    source = "../modules/ingestion_connection_service_manifests"
    ingestion_connection_service_namespace = var.namespace_name
    deployment_image = var.connection_deployment_image
    env_port = var.connection_env_port
    env_host = var.connection_env_host
}
module "keycloak" {
    depends_on = [
      module.add_kubeconfig
    ]
    source                      = "../modules/keycloak_module"
    keycloak_namespace          = var.namespace_name
    image_registry              = var.image_registry
    image_repository            = var.image_repository
    image_tag                   = var.image_tag
    adminUser                   = var.adminUser
    adminPassword               = var.adminPassword
    tls_enabled                 = var.tls_enabled
    tls_autoGenerated           = var.tls_autoGenerated
    production                  = var.production
    httpRelativePath            = var.httpRelativePath
    service_type                = var.service_type
    externalDatabase_host       = module.rds_instance.address
    externalDatabase_port       = module.rds_instance.port
    externalDatabase_user       = module.rds_instance.username
    externalDatabase_database   = var.db_name_4
    externalDatabase_password   = var.password
}
module "glue_artifact_files_1" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_1
    path_to_file                = var.path_to_file_1
}
module "glue_artifact_files_2" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_2
    path_to_file                = var.path_to_file_2
}
module "glue_artifact_files_3" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_3
    path_to_file                = var.path_to_file_3
}
module "glue_artifact_files_4" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_4
    path_to_file                = var.path_to_file_4
}
module "glue_artifact_files_5" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_5
    path_to_file                = var.path_to_file_5
}
module "glue_artifact_files_6" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_6
    path_to_file                = var.path_to_file_6
}
module "glue_artifact_files_7" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_7
    path_to_file                = var.path_to_file_7
}
module "glue_artifact_files_8" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_8
    path_to_file                = var.path_to_file_8
}
module "glue_artifact_files_9" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_9
    path_to_file                = var.path_to_file_9
}
module "glue_artifact_files_10" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_10
    path_to_file                = var.path_to_file_10
}
module "glue_artifact_files_11" {
    depends_on = [
      module.s3_bucket_3
    ]
    source                      = "../modules/s3_object_upload_manifests"
    bucket_name                 = var.bucket_name_3
    bucket_key                  = var.bucket_key_11
    path_to_file                = var.path_to_file_11
}
module "alb_controller" {
    depends_on = [
      module.istio
    ]
    source                      = "../modules/aws_lb_controller_manifests"
    cluster_issuer              = module.eks_cluster.cluster_issuer
    vpcID                       = var.aws_vpc
    aws_region                  = var.region
    cluster_name                = var.eks-name
    image_repository            = var.alb_image_repository
}
