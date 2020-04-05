variable "cloudflare_zone_id" {
  // alexhaydock.co.uk
  default = "86166f80c7b6d612b9807edbdecd9eb0"
}

// create A record for server
resource "cloudflare_record" "A" {
  zone_id = var.cloudflare_zone_id
  name    = var.DESIRED_HOSTNAME
  type    = "A"
  ttl     = 120
  proxied = false
  value   = aws_instance.instance_cloud-quickstart-jitsi.public_ip
}