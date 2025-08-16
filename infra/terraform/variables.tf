variable "region" {
  type    = string
  default = "us-east-1"
}
variable "account_id" {
  type    = string
  default = "014498640669"
}
variable "cluster_name" {
  type    = string
  default = "demo-eks"
}
variable "node_desired_size" {
  type    = number
  default = 1
}
variable "node_max_size" {
  type    = number
  default = 1
}
variable "node_min_size" {
  type    = number
  default = 0
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}