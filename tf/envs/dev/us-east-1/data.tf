data "aws_vpc" "default" {
  tags = {
    Name = "${var.product_name}-${var.product_env}"
  }
}

data "aws_subnet" "default" {
  tags = {
    Name = "${var.product_name}-${var.product_env}-public-us-east-1a"
  }
}