module "api_gateway" {
  source = "github.com/mtranter/serverless-monorepo-terraform.git//infra/modules/api_gateway?ref=v0.1"
  api_name = "PublicAPI"
}