
locals {
  function_name_tokens = split(":", var.function_arn)
}

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = var.queue_arn
  function_name    = var.function_arn
  batch_size       = var.batch_size
}

data "aws_lambda_function" "function" {
  function_name = local.function_name_tokens[length(local.function_name_tokens) - 1]
}

data "aws_iam_policy_document" "can_sqs" {
  statement {
    sid       = "CanSQS"
    actions   = [
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage"
    ]
    resources = [
      var.queue_arn
    ]
  }
  statement {
    sid       = "CanKMS"
    actions   = [
      "kms:Decrypt"
    ]
    resources = [
      var.queue_kms_key_arn]
  }
}

resource "aws_iam_role_policy" "can_read_sqs" {
  role   = data.aws_lambda_function.function.role
  policy = data.aws_iam_policy_document.can_sqs.json
}