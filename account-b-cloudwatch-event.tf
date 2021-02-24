resource "aws_cloudwatch_event_rule" "account-b-update_codecommit_repository" {
  provider = aws.account-b
  name     = "update_codecommit_repository-${local.suffix}"
  event_pattern = jsonencode({
    detail-type : [
      "CodeCommit Repository State Change"
    ],
    resources : [
      "${aws_codecommit_repository.repository.arn}"
    ],
    source : [
      "aws.codecommit"
    ],
    detail : {
      event : [
        "referenceCreated",
        "referenceUpdated"
      ],
      referenceName : [
        "main"
      ]
    }
  })
}

resource "aws_cloudwatch_event_target" "start_pipeline" {
  provider = aws.account-b
  rule     = aws_cloudwatch_event_rule.account-b-update_codecommit_repository.id
  arn      = aws_codepipeline.pipeline.arn
  role_arn = aws_iam_role.cloudwatch-event-rule-update_codecommit_repository-role.arn
}

resource "aws_cloudwatch_event_permission" "CommitPipelineCrossAccountAccess" {
  provider       = aws.account-b
  principal      = data.aws_caller_identity.account-a.account_id
  statement_id   = "CommitPipelineCrossAccountAccess"
  action         = "events:PutEvents"
  event_bus_name = "default"
}
