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
  default     = "1"
}
variable "pvt_min_size" {
  description = "Minimum instance count on node group"
  type        = string
  default     = "1"
}
variable "pvt_max_size" {
  description = "Maximum instance count on node group"
  type        = string
  default     = "1"
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
