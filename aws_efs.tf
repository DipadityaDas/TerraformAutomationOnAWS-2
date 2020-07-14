resource "aws_efs_file_system" "tfefs" {
	creation_token = "tfefs"
	tags = {
		Name = "Tf-efs"
	}
	depends_on = [
		aws_instance.tfos
	]
}