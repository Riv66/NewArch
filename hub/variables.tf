variable "hub_vpc_cidr" {
  description = "CIDR block for the Hub VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "nat_gateway_eip" {
  description = "Elastic IP allocation ID for the NAT Gateway"
  type        = string
}
