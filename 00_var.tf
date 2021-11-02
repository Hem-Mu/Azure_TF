variable "db_admin" {
  type = string
  default = "hamster"
}
variable "db_password" {
  type = string
  default = "q1q1q1q1q!"
}
variable "pub_sub" {
  type = list
  default = ["10.0.0.0/24","10.0.2.0/24"]
}
variable "pri_sub" {
  type = list
  default = ["10.0.1.0/24","10.0.3.0/24"]
}