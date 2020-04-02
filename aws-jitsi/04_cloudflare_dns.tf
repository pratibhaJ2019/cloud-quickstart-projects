variable "cloudflare_zone_id" {
  // darkwebkittens.xyz
  default = "bcf2464ea80f6c630b5eb08cac4feba8"
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