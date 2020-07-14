# Creating S3 bucket to store image
resource "aws_s3_bucket" "tfbucket" {
	bucket = "tfwebproductionbucket-v1"
	acl    = "public-read"

	tags = {
		Name = "Tf-S3-bucket"
	}

	depends_on = [
		null_resource.mount_EFS_volume
	]
}

# Upload the image to S3 bucket
resource "aws_s3_bucket_object" "tfobject" {
	bucket       = aws_s3_bucket.tfbucket.bucket
	key          = "terraformaws.jpg"
	source       = "terraformaws.jpg"
	content_type = "image/jpg"
	acl          = "public-read"

	depends_on = [
		aws_s3_bucket.tfbucket
	]
}
