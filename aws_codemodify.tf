# Modification in html code
resource "null_resource" "tfModify" {
	connection {
		type     	= "ssh"
		user     	= "ec2-user"
		private_key = tls_private_key.tfkey.private_key_pem
		host        = aws_instance.tfos.public_ip
	}

	provisioner "remote-exec" {
		inline	= [
			"sudo sed -i 's@terraformaws.jpg@https://${aws_cloudfront_distribution.tfdistribution.domain_name}/terraformaws.jpg@g' /var/www/html/index.html"
		]
	}
	depends_on = [
		aws_cloudfront_distribution.tfdistribution
	]
}