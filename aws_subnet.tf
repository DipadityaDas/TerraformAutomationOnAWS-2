# Creating a subnet in vpc
resource "aws_subnet" "tfsubnet" {
	vpc_id                  = aws_vpc.tfvpc.id
	availability_zone       = "ap-south-1b"
	cidr_block              = "10.0.1.0/24"
	map_public_ip_on_launch = true

	tags = {
		Name = "Tf-subnet"
	}

	depends_on = [
		aws_vpc.tfvpc
	]
}