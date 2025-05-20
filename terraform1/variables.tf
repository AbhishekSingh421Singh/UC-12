variable "region" {
  default = "us-east-1"
}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "Password for the DB"
  type        = string
  sensitive   = true
}

variable "vpc_id" {}

variable "subnet_ids" {
  type = list(string)
}