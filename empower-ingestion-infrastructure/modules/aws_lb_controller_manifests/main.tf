data "aws_iam_policy_document" "eks_alb_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_issuer, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }
    principals {
      identifiers = [local.oidc_arb]
      type        = "Federated"
    }
  }
}

resource "aws_iam_policy" "alb_controller_policy" {
    name = "EmPowerAmazonEKSLoadBalancerControllerPolicy"
    policy = file("${path.module}/iam_policies/alb_controller_policy.json")
}

module "alb_controller_role" {
  source = "../iam_role_manifests"
  name = "EmPowerAmazonEKSLoadBalancerControllerRole"
  policies = ["EmPowerAmazonEKSLoadBalancerControllerPolicy"]
  assume_role_policy = data.aws_iam_policy_document.eks_alb_assume_role_policy.json
  depends_on = [
    aws_iam_policy.alb_controller_policy
  ]
}

resource "helm_release" "loadbalancer_controller" {
  depends_on = [module.alb_controller_role]
  name       = "aws-load-balancer-controller"

  #repository = "https://aws.github.io/eks-charts"
  chart      = "${path.module}/charts/aws-load-balancer-controller-1.5.3.tgz"

  namespace = "kube-system"

  set {
    name  = "image.repository"
    value = var.image_repository #"602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller" Changes based on Region - This is for us-east-1 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.alb_controller_role.role_arn
  }

  set {
    name  = "vpcId"
    value = var.vpcID
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

}

resource "time_sleep" "wait_300_seconds" {
  create_duration = "300s"
}