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
      Name  = "tf-test"
      ENV   = "terraform-practice"
      Owner = "danimal141"
    }
  }
}
