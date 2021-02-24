resource "aws_iam_role" "codepipeline-codebuild-service-role" {
  provider = aws.account-b
  name     = "codepipeline-codebuild-service-role-${local.suffix}"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Principal : {
          Service : "codebuild.amazonaws.com"
        },
        Effect : "Allow",
        Sid : ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline-codebuild-service-role-policy" {
  provider = aws.account-b
  name     = "codepipeline-codebuild-service-role-policy-${local.suffix}"
  role     = aws_iam_role.codepipeline-codebuild-service-role.id
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : "*",
        Effect : "Allow"
      }
    ]
  })
}
