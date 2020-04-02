resource "aws_key_pair" "key_cloud-quickstart-jitsi" {
  key_name   = "key_cloud-quickstart-jitsi"
  public_key = file(var.AWS_PUBKEY)
}