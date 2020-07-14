# Creating a Routing Table
resource "aws_route_table" "tfroute" {
	vpc_id = aws_vpc.tfvpc.id

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.tfgateway.id
	}

	tags = {
		description = "Route table for inbound traffic to vpc"
	}

	depends_on = [
		aws_internet_gateway.tfgateway
	]
}
