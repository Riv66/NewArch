provider "aws" {
  region = var.region
}

# Create Spoke VPC
resource "aws_vpc" "spoke_vpc" {
  cidr_block = var.spoke_vpc_cidr
  tags = {
    Name = "spoke-vpc"
  }
}

# Create Private Subnets in each AZ
resource "aws_subnet" "private_subnets" {
  count           = length(var.private_subnet_cidrs)
  vpc_id          = aws_vpc.spoke_vpc.id
  cidr_block      = var.private_subnet_cidrs[count.index]
  availability_zone = "${var.region}${element(["a", "b"], count.index % 2)}"

  tags = {
    Name = "spoke-private-subnet-${count.index}"
  }
}

# Attach the Spoke VPC to the Transit Gateway (TGW)
resource "aws_ec2_transit_gateway_vpc_attachment" "spoke_tgw_attachment" {
  subnet_ids         = aws_subnet.private_subnets[*].id
  transit_gateway_id = var.tgw_id
  vpc_id             = aws_vpc.spoke_vpc.id

  tags = {
    Name = "spoke-vpc-tgw-attachment"
  }
}

# Add Route in Spoke VPC to send traffic to the TGW
resource "aws_route" "spoke_to_tgw" {
  count               = length(aws_subnet.private_subnets)
  route_table_id      = aws_vpc.spoke_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id  = var.tgw_id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.spoke_tgw_attachment]
}
