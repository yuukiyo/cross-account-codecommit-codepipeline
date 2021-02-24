resource "aws_cloudwatch_event_rule" "account-a-update_codecommit_repository" {
  provider = aws.account-a
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

resource "aws_cloudwatch_event_target" "cross_account_event_target" {
  provider = aws.account-a
  rule     = aws_cloudwatch_event_rule.account-a-update_codecommit_repository.id
  arn      = "arn:aws:events:${data.aws_region.account-b.name}:${data.aws_caller_identity.account-b.account_id}:event-bus/default"
  role_arn = aws_iam_role.account-a-cloudwatch-event-rule-update_codecommit_repository-role.arn
}
