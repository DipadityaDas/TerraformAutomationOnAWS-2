# Creating a New Security Group
resource "aws_security_group" "tfsg" {
	name        = "Tf-security_group"
	description = "Allow HTTP, ssh for inbound traffic."
	vpc_id      = aws_vpc.tfvpc.id
	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "Tf-Firewall"
	}
	depends_on = [
		aws_route_table_association.tfrouset
	]
}