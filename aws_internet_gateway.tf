# Creating Internet Gateway
resource "aws_internet_gateway" "tfgateway" {
	vpc_id = aws_vpc.tfvpc.id

	tags = {
		description = "Allows connection to VPC and EC2 instance."
	}

	depends_on = [
		aws_vpc.tfvpc
	]
}
