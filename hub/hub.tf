provider "aws" {
  region = var.region
}

# Create Hub VPC
resource "aws_vpc" "hub_vpc" {
  cidr_block = var.hub_vpc_cidr
  tags = {
    Name = "hub-vpc"
  }
}

# Create an Internet Gateway (IGW)
resource "aws_internet_gateway" "hub_igw" {
  vpc_id = aws_vpc.hub_vpc.id
}

# Create Public Subnet for the Hub
resource "aws_subnet" "hub_public_subnet" {
  vpc_id                  = aws_vpc.hub_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
  depends_on = [aws_internet_gateway.hub_igw]
}

# Create NAT Gateway in the public subnet
resource "aws_nat_gateway" "hub_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.hub_public_subnet.id
}

# Create a Transit Gateway (TGW)
resource "aws_ec2_transit_gateway" "tgw" {
  description = "Centralized TGW for Hub and Spoke architecture"
  tags = {
    Name = "hub-spoke-tgw"
  }
}

# Output Transit Gateway ID and Hub VPC Info
output "tgw_id" {
  description = "Transit Gateway ID"
  value       = aws_ec2_transit_gateway.tgw.id
}

output "hub_vpc_id" {
  description = "Hub VPC ID"
  value       = aws_vpc.hub_vpc.id
}

output "hub_public_subnet_id" {
  description = "Hub Public Subnet ID"
  value       = aws_subnet.hub_public_subnet.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.hub_nat_gw.id
}
