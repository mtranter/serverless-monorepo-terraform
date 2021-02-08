variable "dynamo_table_names" {
  type = list(string)
}

variable "sqs_queue_names" {
  type = list(string)
}

variable "sns_topic_names" {
  type = list(string)
}

variable "kms_key_ids" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "account" {
  type = string
}
