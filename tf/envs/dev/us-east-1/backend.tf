terraform {
  backend "s3" {
    bucket         = "terraform-states"
    key            = "11111111111/openvpn/us-east-1/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
  }
}