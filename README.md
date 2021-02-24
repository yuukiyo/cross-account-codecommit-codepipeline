# cross-account-codecommit-codepipeline
### How to use
1. edit aws.tf
```
> cat aws.tf
provider "aws" {
  alias = "account-a"
  assume_role {
    role_arn = "xxx" // AccountA IAM Role ARN
  }
}

provider "aws" {
  alias = "account-b"
  assume_role {
    role_arn = "xxx" // AccountB IAM Role ARN
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

```

2. terraform apply
