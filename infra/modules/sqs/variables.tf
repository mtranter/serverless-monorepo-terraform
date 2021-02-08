variable "queue_name" {
  description = "Queue name"
}
variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "tags" {
  type = map(string)
}

variable "kms_key_id" {}

variable "delay_seconds" {
  description = "The queue delay seconds. Defaul 0"
  default     = 0
  type        = number
}

variable "message_retention_seconds" {
  type    = number
  default = 1209600
}

variable "visibility_timeout_seconds" {
  default = 30
  type    = number
}