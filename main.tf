provider "aws" {
  region = "us-east-1"
}

# Call the Hub module
module "hub" {
  source = "./modules/hub"

  hub_vpc_cidr     = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  region           = "us-east-1"
  nat_gateway_eip  = "eipalloc-123456789"  # Replace with a real EIP allocation
}

# Call the Spoke VPC 1 module
module "spoke_vpc_1" {
  source = "./modules/spoke"

  spoke_vpc_cidr    = "10.1.0.0/16"
  private_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
  region            = "us-east-1"
  tgw_id            = module.hub.tgw_id
  hub_vpc_id        = module.hub.hub_vpc_id
}

# Call the Spoke VPC 2 module
module "spoke_vpc_2" {
  source = "./modules/spoke"

  spoke_vpc_cidr    = "10.2.0.0/16"
  private_subnet_cidrs = ["10.2.1.0/24", "10.2.2.0/24"]
  region            = "us-east-1"
  tgw_id            = module.hub.tgw_id
  hub_vpc_id        = module.hub.hub_vpc_id
}

