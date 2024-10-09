Brief 1:
Controlled public access via shared public egress resources: NAT-GW + IGW
Components: 
	• Centralized Egress VPC (Hub VPC) with NAT Gateway and Internet Gateway.
	• Two Spoke VPCs with private subnets in each availability zone.
	• AWS Transit Gateway (TGW) to interconnect the VPCs.

• Hub Module: This will create the centralized egress VPC (Hub VPC) with an Internet Gateway (IGW), NAT Gateway (NAT GW), and a Transit Gateway (TGW).
• Spoke Module: This will create Spoke VPCs, private subnets, and attach them to the Transit Gateway (TGW) from the Hub module.

• Dir structure:
main.tf
terraform.tfvars
modules/
  hub/
    hub.tf
    outputs.tf
    variables.tf
  spoke/
    spoke.tf
    outputs.tf
    variables.tf
