variable "security_group_name" {
  default = "terraform-sg"
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-west-2"
}
variable "AMIS" {
  type = "map"
  default = {
    eu-west-2 = "ami-e05a4d84"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "~/.ssh/terraform"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/terraform.pub"
}
variable "INSTANCE_USERNAME" {
  default = "centos"
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
