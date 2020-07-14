# Output public ip of EC2 Instance
output "Public_IP" {
	value = "${aws_instance.tfos.public_ip}"
}

# Start in the default browser
resource "null_resource" "StartBrowsing" {
	provisioner "local-exec" {
		command = "start msedge ${aws_instance.tfos.public_ip}"
	}
	depends_on = [
		null_resource.tfModify
	]
}