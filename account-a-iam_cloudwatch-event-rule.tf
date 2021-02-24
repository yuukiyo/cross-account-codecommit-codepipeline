resource "aws_iam_role" "account-a-cloudwatch-event-rule-update_codecommit_repository-role" {
  provider = aws.account-a
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

resource "aws_iam_role_policy" "account-a-cloudwatch-event-rule-update_codecommit_repository-role-policy" {
  provider = aws.account-a
  name     = "cw-event-rule-update_codecommit_repository-role-policy-${local.suffix}"
  role     = aws_iam_role.account-a-cloudwatch-event-rule-update_codecommit_repository-role.id
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "events:PutEvents"
        ],
        Resource : [
          "arn:aws:events:${data.aws_region.account-b.name}:${data.aws_caller_identity.account-b.account_id}:event-bus/default"
        ]
      }
    ]
  })
}
