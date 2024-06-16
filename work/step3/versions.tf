terraform {
  required_providers {
    aws = {
      version = ">= 4.49.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Name  = "step3"
      ENV   = "terraform-practice"
      Owner = "danimal141"
    }
  }
}
