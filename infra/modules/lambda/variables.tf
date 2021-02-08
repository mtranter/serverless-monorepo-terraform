variable "name" {
  type = string
}

variable "handler" {
  type = string
}

variable "publish" {
  type = bool
}

variable "source_code_hash" {
  type    = string
  default = null
}

variable "filename" {
  type = string
}

variable "timeout" {
  type    = number
  default = 30
}

variable "memory_size" {
  type    = number
  default = 512
}

variable "layer_arns" {
  type = list(string)
}

variable "concurrency" {
  type    = number
  default = 0
}

variable "env_vars" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
