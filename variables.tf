variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "name" {
  type    = string
  default = "test-mapstore"
}
