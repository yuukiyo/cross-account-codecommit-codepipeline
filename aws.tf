provider "aws" {
  alias = "account-a"
  assume_role {
    role_arn = "xxx"
  }
}

provider "aws" {
  alias = "account-b"
  assume_role {
    role_arn = "xxx"
  }
}

data "aws_caller_identity" "account-a" {
  provider = aws.account-a
}

data "aws_caller_identity" "account-b" {
  provider = aws.account-b
}

data "aws_region" "account-b" {
  provider = aws.account-b
}
