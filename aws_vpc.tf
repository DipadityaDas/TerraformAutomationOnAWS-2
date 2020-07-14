# Create a VPC in the same Availability Zone
resource "aws_vpc" "tfvpc" {
	cidr_block       = "10.0.0.0/16"
	instance_tenancy = "default"
	tags = {
		Name = "Tf-vpc"
	}
}