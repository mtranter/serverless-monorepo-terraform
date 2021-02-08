variable "sqs_queue_arn" {
  type = string
}

variable "sqs_queue_id" {
  type = string
}

variable "sns_topic_arn" {
  type = string
}

variable "raw_message_delivery" {
  default = true
  type    = bool
}

variable "create_queue_policy" {
  description = <<DESCRIPTION
In order for SNS to forward messages to SQS, the SQS policy must grant sqs:SendMessage to SNS.
This module will set this policy by default, however if you require a different policy on this queue,
set this flag to false. The default policy looks like this:
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "SNSCanSendToQueue",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "<your queue arn>",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "<your topic arn>"
        }
      }
    }
  ]
}
DESCRIPTION
  type        = bool
  default     = true
}