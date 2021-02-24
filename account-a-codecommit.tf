resource "aws_codecommit_repository" "repository" {
  provider        = aws.account-a
  repository_name = "repository-${local.suffix}"
}
