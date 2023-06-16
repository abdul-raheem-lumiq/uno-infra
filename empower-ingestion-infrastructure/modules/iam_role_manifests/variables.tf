variable "name" {
}
variable "policies" {
    default = ["AmazonEKSClusterPolicy", "AmazonEKSVPCResourceController"]
}
variable "tags" {
  default = {}
}
variable "permissions_boundary" {
  default = null
}
variable "assume_role_policy" {
    description = "data.aws_iam_policy_document.eks_alb_assume_role_policy.json"
}