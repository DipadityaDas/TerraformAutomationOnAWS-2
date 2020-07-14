resource "aws_instance" "tfos" {
	ami                    = "ami-08706cb5f68222d09"
	instance_type          = "t2.micro"
	key_name               = aws_key_pair.deployer.key_name
	vpc_security_group_ids = ["${aws_security_group.tfsg.id}"]
	subnet_id              = aws_subnet.tfsubnet.id
	connection {
		type        = "ssh"
		user        = "ec2-user"
		private_key = tls_private_key.tfkey.private_key_pem
		host        = aws_instance.tfos.public_ip
	}
	provisioner "remote-exec" {
		inline = [
			"sudo yum update -y",
			"sudo yum install httpd php git amazon-efs-utils -y",
			"sudo service httpd start",
			"sudo chkconfig httpd on"
		]
	}
	tags = {
		Name = "AmazonOS"
	}
	depends_on = [
		aws_key_pair.deployer
	]
}