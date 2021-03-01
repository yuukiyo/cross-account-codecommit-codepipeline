resource "aws_iam_role" "codepipeline-role" {
  provider = aws.account-b
  name     = "codepipeline-role-${local.suffix}"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Principal : {
          Service : "codepipeline.amazonaws.com"
        },
        Effect : "Allow",
        Sid : ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline-role-policy" {
  provider = aws.account-b
  name     = "codepipeline-role-policy-${local.suffix}"
  role     = aws_iam_role.codepipeline-role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Resource : aws_iam_role.codepipeline-codecommit-role.arn,
        Effect : "Allow"
      },
      {
        Action : "sts:AssumeRole",
        Resource : aws_iam_role.codepipeline-codebuild-role.arn,
        Effect : "Allow"
      }
    ]
  })
}
