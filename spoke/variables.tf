variable "spoke_vpc_cidr" {
  description = "CIDR block for the Spoke VPC"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "tgw_id" {
  description = "Transit Gateway ID from Hub"
  type        = string
}

variable "hub_vpc_id" {
  description = "Hub VPC ID for route table"
  type        = string
}
