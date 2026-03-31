variable "name" {}
variable "region" {}
variable "size" {}
variable "image" {}
variable "vpc_id" {}

variable "ssh_keys" {
  type    = list(string)
  default = []
}
