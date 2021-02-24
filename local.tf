locals {
  suffix = substr(lower(base64sha256("cross account codepipeline")), 0, 10)
}
