resource "aws_key_pair" "key_cloud-quickstart-wp" {
  key_name   = "key_cloud-quickstart-wp"
  public_key = file(var.AWS_PUBKEY)
}