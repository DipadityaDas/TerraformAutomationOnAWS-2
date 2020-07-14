resource "aws_efs_mount_target" "tfmountefs" {
	file_system_id = aws_efs_file_system.tfefs.id
	subnet_id      = aws_subnet.tfsubnet.id
	security_groups = [aws_security_group.tfsg.id]
	
	depends_on = [
		aws_efs_file_system.tfefs
	]
}
