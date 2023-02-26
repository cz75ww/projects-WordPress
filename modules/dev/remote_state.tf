data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "fpsouza-bootcamp-infra-as-code"
    key    = "bootcamp/dev/terraform.tfstate"
    region = "us-east-1"
  }
}