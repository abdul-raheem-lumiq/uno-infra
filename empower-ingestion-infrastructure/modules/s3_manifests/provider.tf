terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
#     backend "s3" {
#     bucket = "empower-ingestion-terraform-backend-bucket"
#     key    = "s3/"
#     region = "ap-south-1"
#   }
}

provider "aws" {
    region = "ap-south-1"
}