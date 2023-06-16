terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
        null = {
            source = "hashicorp/null"
            version = "3.2.1"
        }
        tls = {
            source = "hashicorp/tls"
            version = "4.0.4"
        }
        local = {
            source = "hashicorp/local"
            version = "2.4.0"
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "2.20.0"
        }
        helm = {
            source = "hashicorp/helm"
            version = "2.9.0"
        }
    }
    backend "s3" {
    bucket = "empower-ingestion-terraform-backend-bucket"
    key    = "ingestion-terraform-bk"
    region = "ap-south-1"
  }
}

provider "aws" {
    region = "ap-south-1"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  #config_context = "drishti-dev"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}