resource "aws_codebuild_project" "project" {
  provider     = aws.account-b
  name         = "ProjectName-${local.suffix}"
  service_role = aws_iam_role.codepipeline-codebuild-service-role.arn
  artifacts {
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 0
    buildspec = jsonencode({
      phases : {
        build : {
          commands : [
            "ls -al"
          ]
        },
      },
      version : "0.2"
    })
  }
}
