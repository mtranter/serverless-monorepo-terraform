resource "aws_sqs_queue" "dead_letter_queue" {
  name = "${var.queue_name}-dlq"

  kms_master_key_id                 = kms_key_id
  kms_data_key_reuse_period_seconds = 300

  tags = var.tags
}

resource "aws_sqs_queue" "queue" {
  name                       = var.queue_name
  delay_seconds              = var.delay_seconds
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dead_letter_queue.arn}\",\"maxReceiveCount\":100}"

  kms_master_key_id                 = kms_key_id
  kms_data_key_reuse_period_seconds = 300

  tags = var.tags
}