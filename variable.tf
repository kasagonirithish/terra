variable "region" {
  description = " it is a aws region"
  type        = string
}

variable "vpc-cidr" {
  description = " it is a vpc id"
  type        = string
}

variable "subnet-cidr" {
  description = " it is a subnet cidr"
  type        = string
}

variable "availability-zone" {
  description = " it is availability zone "
  type        = string
}

variable "instance-type" {
  description = " it is instance type "
  type        = string
}

variable "ami-id" {
  description = " it is ami id "
  type        = string
}