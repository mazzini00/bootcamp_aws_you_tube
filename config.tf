terraform {
  required_version = ">=1.1.0"
 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  profile = "terraform"

default_tags {
    tags = {
      managed-by = "terraform"
    }
  }
}