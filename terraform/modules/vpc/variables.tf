variable "project_name" {
  description = "Ten project, dung lam tien to dat ten tai nguyen"
  type        = string
}

variable "vpc_cidr" {
  description = "Dai IP cua VPC"
  type        = string
}
variable "public_subnet_cidr" {
  description = "Dai IP public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Dai IP private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Vung dat subnet (phai thuoc region dang dung)"
  type        = string
}