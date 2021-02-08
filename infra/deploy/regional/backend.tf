terraform {
  backend "s3" {
    region = "ap-southeast-2"
    key = "infra/regional/terraform.tfstate"
    bucket = "engitano-serverless-mono"
  }
}