output "cluster_issuer" {
    value = resource.aws_eks_cluster.eks-cluster.identity.0.oidc.0.issuer
}