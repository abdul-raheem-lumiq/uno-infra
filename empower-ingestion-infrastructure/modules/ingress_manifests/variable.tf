variable "certificate_arn" {
    type        = string
    default     = "arn:aws:acm:ap-south-1:660061364911:certificate/ecc5acb8-ac02-48eb-903e-057efec061e5"
    description = "certificate arn"
}
variable "ingress_manifests_namespace" {
    type = string
    default = "istio-system"
    description = "ingress namespace"
}

variable "backend_service" {
    type = string
    default = "istio-ingress"
    description = "backend service"
}

variable "alb_name" {
    type = string
    default = "empower-ingress"
    description = "alb name"
}

variable "subnets" {
    type = string
    default = "subnet-03fc40e8f2c87cb10,subnet-0e00434f6bceffa21"
    description = "subnets"
}