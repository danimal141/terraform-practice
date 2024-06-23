terraform {
  required_providers {
    aws = {
      version = ">= 4.49.0"
    }
  }

  # 初回実行時は以下をコメントアウト。tf-backendモジュール実行後に以下を追加
  # backend "s3" {
  #   bucket         = "terraform-practice-danimal141-tfstate"
  #   key            = "tf-backend/terraform.tfstate"
  #   encrypt        = true
  #   dynamodb_table = "terraform-practice-danimal141-tfstate-lock"
  #   region         = "ap-northeast-1"
  # }

}

provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Name  = "step5"
      ENV   = "terraform-practice"
      Owner = "danimal141"
    }
  }
}
