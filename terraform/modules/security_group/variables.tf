variable "name" {
  description = "Ten security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC chua security group"
  type        = string
}

variable "ingress_rules" {
  description = "Danh sach luat ingress"
  type = list(object({
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string), [])
    source_security_group_id = optional(string, null)
  }))
  default = []
}