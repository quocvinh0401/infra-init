terraform {
  backend "s3" {
    bucket = "demo-init-state"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
