# Creating an association between subnet and route table
resource "aws_route_table_association" "tfrouset" {
	subnet_id      = aws_subnet.tfsubnet.id
	route_table_id = aws_route_table.tfroute.id

	depends_on = [
		aws_subnet.tfsubnet,
		aws_route_table.tfroute
	]
}
