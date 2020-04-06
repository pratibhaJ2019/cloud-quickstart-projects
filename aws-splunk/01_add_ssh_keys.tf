resource "aws_key_pair" "key_cloud-quickstart-splunk" {
  key_name   = "key_cloud-quickstart-splunk"
  public_key = file(var.AWS_PUBKEY)
}