variable "queue_arn" {
  type = string
}

variable "function_arn" {
  type = string
}

variable "batch_size" {
  type    = number
  default = 1
}

variable "queue_kms_key_arn" {
  type = string
}
