resource "aws_iam_role" "codepipeline-codebuild-role" {
  provider = aws.account-b
  name     = "codepipeline-codebuild-role-${local.suffix}"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Principal : {
          AWS : aws_iam_role.codepipeline-role.arn
        },
        Effect : "Allow",
        Sid : ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline-codebuild-role-policy" {
  provider = aws.account-b
  name     = "codepipeline-codebuild-role-policy-${local.suffix}"
  role     = aws_iam_role.codepipeline-codebuild-role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:StopBuild"
        ],
        Resource : aws_codebuild_project.project.arn,
        Effect : "Allow"
      },
      {
        Action : [
          "logs:CreateLogGroup"
        ],
        Resource : "*",
        Effect : "Allow"
      }
    ]
  })
}
