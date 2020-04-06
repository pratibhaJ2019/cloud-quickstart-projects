resource "aws_key_pair" "key_cloud-quickstart-cowrie" {
  key_name   = "key_cloud-quickstart-cowrie"
  public_key = file(var.AWS_PUBKEY)
}