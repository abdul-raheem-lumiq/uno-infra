variable "cluster_issuer" {
  description = "cluster issuer endpoint eg. resource.aws_eks_cluster.eks-cluster.identity.0.oidc.0.issuer" #cluster_issuer
}
variable "vpcID" {
  description = "VPC ID"
}
variable "aws_region" {
  default = "ap-south-1"
  description = "aws region"
}
variable "cluster_name" {
  description = "cluster-name"
}
variable "image_repository" {
  description = "image respository"
  default = "public.ecr.aws/eks/aws-load-balancer-controller"
}