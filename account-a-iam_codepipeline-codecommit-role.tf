resource "aws_iam_role" "codepipeline-codecommit-role" {
  provider = aws.account-a
  name     = "codepipeline-codecommit-role-${local.suffix}"
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

resource "aws_iam_role_policy" "codepipeline-codecommit-role-policy" {
  provider = aws.account-a
  name     = "codepipeline-codecommit-role-policy-${local.suffix}"
  role     = aws_iam_role.codepipeline-codecommit-role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : [
          "s3:Get*",
          "s3:Put*",
        ],
        Resource : "${aws_s3_bucket.codepipeline_bucket.arn}/*",
        Effect : "Allow"
      },
      {
        Action : [
          "s3:ListBucket",
        ],
        Resource : aws_s3_bucket.codepipeline_bucket.arn,
        Effect : "Allow"
      },
      {
        Action : [
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*"
        ],
        Resource : aws_kms_key.codepipeline_key.arn,
        Effect : "Allow"
      },
      {
        Action : [
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:UploadArchive",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:CancelUploadArchive"
        ],
        Resource : aws_codecommit_repository.repository.arn,
        Effect : "Allow"
      }
    ]
  })
}
