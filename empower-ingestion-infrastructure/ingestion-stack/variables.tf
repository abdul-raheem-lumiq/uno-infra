variable identifier {
  type        = string
  default     = ""
  description = "Name of RDS"
}
variable username {
  type        = string
  default     = ""
  description = "Username for RDS"
}
variable password {
  type        = string
  default     = ""
  description = "Password for RDS"
}
variable vpc_id {
  default     = ""
  description = "vpc id for rds"
}
variable db_subnet_ids {
  default     = ""
  description = "Subnet ids for subnet group in arrays"
}
variable db_subnet_group_name {
  type        = string
  default     = ""
  description = "Name of DB subnet group"
}
variable sg_name {
  type        = string
  default     = ""
  description = "Name of rds security group"
}
variable bucket_name_1 {
  type        = string
  default     = ""
  description = "Name of S3 bucket"
}
variable bucket_name_2 {
  type        = string
  default     = ""
  description = "Name of S3 bucket"
}
variable bucket_name_3 {
  type        = string
  default     = ""
  description = "Name of S3 bucket"
}
variable bucket_name_4 {
  type        = string
  default     = ""
  description = "Name of S3 bucket"
}
variable db_name_1 {
  type        = string
  default     = ""
  description = "Name of DB to be created"
}
variable db_name_2 {
  type        = string
  default     = ""
  description = "Name of DB to be created"
}
variable db_name_3 {
  type        = string
  default     = ""
  description = "Name of DB to be created"
}
variable db_name_4 {
  type        = string
  default     = "keycloak_db"
  description = "Namr of keycloak DB"
}

variable "aws_vpc" {
  description = "VPC id for the cluster"
  type        = string
  default     = "vpc-0eb01e89554906a06"
}
variable "eks-name-sg" {
  description = "EKS security group name"
  type        = string
  default     = "empower-foundation-ingestion-eks-cluster-sg"
}
variable "nodes_sg_name-eks-nodes" {
  description = "Name of node security group"
  type        = string
  default     = "empower-foundation-ingestion-eks-node-sg"
}
variable "eks-name" {
  description = "Name of EKS cluster"
  type        = string
  default     = "empower-foundation-ingestion-eks"
}
variable "privatesubnet1" {
  description = "Name of EKS subnet 1"
  type        = string
  default     = "subnet-0e00434f6bceffa21"
}
variable "privatesubnet2" {
  description = "Name of EKS subnet 2"
  type        = string
  default     = "subnet-03fc40e8f2c87cb10"
}
variable "endpoint_public_access" {
  description = "Public enpoint value (True/False)"
  type        = string
  default     = "false"
}
variable "endpoint_private_access" {
  description = "Private endpoint value (True/False)"
  type        = string
  default     = "true"
}
variable "ng-name" {
  description = "Name of the node group"
  type        = string
  default     = "empower-foundation-ingestion-ng-01"
}
variable "ami_type" {
  description = "AMI value for node group instances"
  type        = string
  default     = "AL2_x86_64"
}
variable "disk_size" {
  description = "Disk size for node group instances"
  type        = string
  default     = "50"
}
variable "instance_types" {
  description = "Instance type for node groups"
  type        = string
  default     = "t3.medium"
}
variable "version-cluster" {
  description = "Version for EKS cluster"
  type        = string
  default     = "1.22"
}
# variable eks-key-pair {
#   type        = string
#   default     = "empower-foundation-ingestion-eks"
#   description = "Key pair name for EKS and nodes"
# }

# variable "aws_key_pair" {
#   description = "key pair for ec2 login"
#   type        = string
#   default     = "pryzm.pem"
# }
variable "pvt_desired_size" {
  description = "Desired instance count on node group"
  type        = string
  default     = "2"
}
variable "pvt_min_size" {
  description = "Minimum instance count on node group"
  type        = string
  default     = "2"
}
variable "pvt_max_size" {
  description = "Maximum instance count on node group"
  type        = string
  default     = "3"
}
variable logtypes {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "Logging inputs"
}
variable eks_iam_role {
  type        = string
  default     = "empower-foundation-ingestion-eks-role"
  description = "Name of IAM role for EKS"
}
variable kube_proxy_version {
  type        = string
  default     = "v1.21.2-eksbuild.2"
  description = "kube proxy version"
}
variable vpc_cni_version {
  type        = string
  default     = "v1.10.1-eksbuild.1"
  description = "vpc cni version"
}
variable region {
  type        = string
  default     = "ap-south-1"
  description = "region"
}
variable namespace_name {
  type        = string
  default     = "ingestion-app"
  description = "Name of namespace"
}
variable istio_version {
  type        = string
  default     = "1.14"
  description = "istio version"
}
variable "istio_namespace_name" {
  type        = string
  default     = "istio-system"
  description = "istio namespace"
}
variable image_registry {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com"
  description = "Keycloak image registry"
}
variable image_repository {
  type        = string
  default     = "keycloack"
  description = "Key cloak image repository"
}
variable image_tag {
  type        = string
  default     = "base"
  description = "image tag"
}
variable adminUser {
  type        = string
  default     = "admin"
  description = "admin username"
}
variable adminPassword {
  type        = string
  default     = "Password123" //CHANGE IT
  description = "password for admin user"
}
variable tls_enabled {
  default     = true
  description = "tls enabled"
}
variable tls_autoGenerated {
  default     = true
  description = "auto generate tls certificate"
}
variable production {
  default     = true
  description = "production"
}
variable httpRelativePath {
  type        = string
  default     = "/auth/"
  description = "relatve path"
}
variable service_type {
  type        = string
  default     = "ClusterIP"
  description = "service type"
}
variable externalDatabase_host {
  type        = string
  default     = "pryzm-db.cepsv5f9ayrr.ap-south-1.rds.amazonaws.com"
  description = "Host for external postgres DB"
}
variable externalDatabase_port {
  default     = 5432
  description = "database port"
}
variable externalDatabase_user {
  type        = string
  default     = "postgres"
  description = "external user name"
}
variable externalDatabase_database {
  type        = string
  default     = "test_keycloak_db"
  description = "external postgres db name"
}
variable externalDatabase_password {
  type        = string
  default     = "lumiq123"
  description = "external db password"
}
variable "bucket_key_1" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_1" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_2" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_2" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_3" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_3" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_4" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_4" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_5" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_5" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_6" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_6" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_7" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_7" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_8" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_8" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_9" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_9" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_10" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_10" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}
variable "bucket_key_11" {
  type = string
  default = "new_object_key"
  description = "bucket key"
}
variable "path_to_file_11" {
  type = string
  default = "/path/to/file"
  description = "path to file"
}

variable "alb_image_repository" {
  type = string
  default = "public.ecr.aws/eks/aws-load-balancer-controller"
  description = "image repo for alb"
}
variable ingestion_bk_deployment_image {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com/empower-foundation-ingestion-backend:29"
  description = "deployment image"
}

variable ingestion_bk_env_port {
  default     = "6100"
  description = "container port number"
}

variable ingestion_bk_env_host {
  default     = "0.0.0.0"
  description = "env host name"
}

variable ingestion_bk_env_databasetype {
  type        = string
  default     = "postgres"
  description = "database type"
}

variable airflow_user_name {
  type        = string
  default     = "admin"
  description = "airflow user"
}

variable airflow_password {
  type        = string
  default     = "admin"
  description = "airflow password"
}

variable env_airflowhost {
  type        = string
  default     = "aca76fdfbd51d4bb6a7ee497a006d4af-3b8a641fd007b2fa.elb.ap-south-1.amazonaws.com"
  description = "airflow host"
}

variable env_airflowport {
  default     = "80"
  description = "airflow port"
}
variable frontend_deployment_image {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com/empower-foundation-ingestion-frontend:48"
  description = "deployment image"
}

variable frontend_env_viteapiurl {
  type        = string
  default     = "my-secret-api-key-devel"
  description = "env viteapiurl"
}

# variable env_vitebaseurl {
#   type        = string
#   default     = "http://afdc28bdbdf16407788e4764f29d8447-7e1621d8a5ccec79.elb.ap-south-1.amazonaws.com"
#   description = "env vitebaseurl"
# }

# variable env_viteconnectionurl {
#   type        = string
#   default     = "http://a76c539a7ae144ce695dd6bf0d9a584a-b737aa7236751511.elb.ap-south-1.amazonaws.com"
#   description = "env viteconnectionurl"
# }

# variable virtualService_uriPrefix {
#   type        = string
#   default     = "/"
#   description = "env virtualService uriPrefix"
# }

# variable virtualService_uriPrefixWithoutSlash {
#   type        = string
#   default     = "/"
#   description = "env virtualService uriPrefixWithoutSlash"
# }
variable "alb_certificate_arn" {
    type        = string
    default     = "arn:aws:acm:ap-south-1:660061364911:certificate/ecc5acb8-ac02-48eb-903e-057efec061e5"
    description = "certificate arn"
}
variable "ingress_manifests_namespace" {
    type = string
    default = "istio-system"
    description = "ingress namespace"
}
variable "ingress_backend_service" {
    type = string
    default = "istio-ingress"
    description = "backend service"
}
variable "alb_name" {
    type = string
    default = "empower-foundation-ingestion-ingress-alb"
    description = "alb name"
}
variable "alb_subnets" {
    type = string
    default = "subnet-03fc40e8f2c87cb10,subnet-0e00434f6bceffa21"
    description = "subnets"
}
variable connection_deployment_image {
  type        = string
  default     = "660061364911.dkr.ecr.ap-south-1.amazonaws.com/empower-foundation-ingestion-automation:3"
  description = "deployment image"
}
variable connection_env_port {
  default     = "6200"
  description = "env port"
}
variable connection_env_host {
  default     = "0.0.0.0"
  description = "env host"
}