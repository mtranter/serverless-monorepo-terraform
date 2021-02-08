resource "aws_sns_topic_subscription" "subscription" {
  endpoint             = var.sqs_queue_arn
  protocol             = "sqs"
  topic_arn            = var.sns_topic_arn
  raw_message_delivery = var.raw_message_delivery
}

resource "aws_sqs_queue_policy" "account_queue_policy" {
  count     = var.create_queue_policy ? 1 : 0
  queue_url = var.sqs_queue_id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "SNSCanSendToQueue",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${var.sqs_queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.sns_topic_arn}"
        }
      }
    }
  ]
}
EOF
}