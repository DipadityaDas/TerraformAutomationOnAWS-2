# Mounting the Drive to the AWS Instance
resource "null_resource" "mount_EFS_volume" {
	# Creating a connection for mounting the drive using SSH
	connection {
		type        = "ssh"
		user        = "ec2-user"
		private_key = tls_private_key.tfkey.private_key_pem
		host        = aws_instance.tfos.public_ip
	}

	provisioner "remote-exec" {
		inline = [
			# Command to auto mount the EFS Volume to the EC2 instance after every restart!
			"sudo echo ${aws_efs_file_system.tfefs.id}:/ /var/www/html efs defaults,_netdev 0 0 >> sudo /etc/fstab",
			
			# Command to mount the EFS volume to the instance!
			"sudo mount -t efs ${aws_efs_file_system.tfefs.id}:/ /var/www/html",
			
			# Command to download the webpage contents from the GitHub Repository to a file!
			"sudo curl https://raw.githubusercontent.com/DipadityaDas/TerraformWebpage/master/index.html > index.html",
			
			# Command to copy the file in the webserver directory!
			"sudo cp index.html /var/www/html/"
		]
	}
	# Creating this dependency so that provisioner does 
	# not run before the volume attachment is done!
	depends_on = [
		aws_instance.tfos,
		aws_efs_file_system.tfefs,
		aws_efs_mount_target.tfmountefs,
	]
}