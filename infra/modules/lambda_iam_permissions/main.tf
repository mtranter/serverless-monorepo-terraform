
data "aws_iam_policy_document" "lambda_can" {

  dynamic statement {
    for_each = length(coalesce(var.dynamo_table_names, [])) > 0 ? [
      1] : []
    content {
      sid       = "CanDynamo"
      actions   = [
        "dynamodb:Batch*",
        "dynamodb:DeleteItem",
        "dynamodb:Describe*",
        "dynamodb:GetItem",
        "dynamodb:PartiQL*",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
      ]
      resources = [for table in var.dynamo_table_names : "arn:aws:dynamodb:${var.region}:${var.account}:table/${table}"]
    }
  }

  dynamic statement {
    for_each = length(coalesce(var.sqs_queue_names, [])) > 0 ? [
      1] : []
    content {
      sid       = "CanSQS"
      actions   = [
        "sqs:SendMessage",
        "sqs:SendMessageBatch"
      ]
      resources = [for queue in var.sqs_queue_names : "arn:aws:sqs:${var.region}:${var.account}:${queue}"]
    }
  }

  dynamic statement {
    for_each = length(coalesce(var.sns_topic_names, [])) > 0 ? [
      1] : []
    content {
      sid       = "CanSNS"
      actions   = [
        "sns:Publish"
      ]
      resources = [for topic in var.sns_topic_names : "arn:aws:sns:${var.region}:${var.account}:${topic}"]
    }
  }

  dynamic statement {
    for_each = length(coalesce(var.kms_key_ids, [])) > 0 ? [
      1] : []
    content {
      sid       = "CanKMS"
      actions   = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey"
      ]
      resources = [for key in var.kms_key_ids : "arn:aws:kms:${var.region}:${var.account}:key/${key}"]
    }
  }
}