#Innitialization Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

#Running provided services which is AWS
provider "aws" {
  region = var.region
}