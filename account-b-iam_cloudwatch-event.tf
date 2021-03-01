resource "aws_iam_role" "cloudwatch-event-rule-update_codecommit_repository-role" {
  provider = aws.account-b
  name     = "cw-event-rule-update_codecommit_repository-role-${local.suffix}"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "events.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudwatch-event-rule-update_codecommit_repository-role-policy" {
  provider = aws.account-b
  name     = "cw-event-rule-update_codecommit_repository-role-policy-${local.suffix}"
  role     = aws_iam_role.cloudwatch-event-rule-update_codecommit_repository-role.id
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "codepipeline:StartPipelineExecution",
        Resource : aws_codepipeline.pipeline.arn,
        Effect : "Allow"
      }
    ]
  })
}
