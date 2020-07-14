# Generating a private_key
resource "tls_private_key" "tfkey" {
	algorithm = "RSA"
	rsa_bits  = 4096
	depends_on = [
		aws_security_group.tfsg
	]
}

resource "local_file" "private-key" {
	content         = tls_private_key.tfkey.private_key_pem
	filename        = "Tfkey.pem"
}

resource "aws_key_pair" "deployer" {
	key_name   = "Tfkey"
	public_key = tls_private_key.tfkey.public_key_openssh
	depends_on = [
		tls_private_key.tfkey
	]
}