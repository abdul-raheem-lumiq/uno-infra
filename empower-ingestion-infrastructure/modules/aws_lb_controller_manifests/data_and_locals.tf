data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  oidc_arb = join("", [
        "arn:aws:iam::", data.aws_caller_identity.current.account_id, 
        ":oidc-provider/",replace(var.cluster_issuer, "https://", "")
        ])
}

locals {
  account_id = data.aws_caller_identity.current.account_id
}