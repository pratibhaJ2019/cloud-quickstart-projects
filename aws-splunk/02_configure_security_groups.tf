resource "aws_security_group" "sg_cloud-quickstart-splunk" {
  name        = "sg_cloud-quickstart-splunk"
  description = "Cloud Quickstart Security Group "

  ingress {
    # Allow SSH in only from our current public IP (we will tunnel to access the Splunk WebUI on :8000)
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.MY_PUBLIC_IP]
  }

  ingress {
    # Allow Splunk HTTP event collector ingress (it's behind the proxy on port 8088 but externally it's 443 with a LE cert)
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    # Allow Splunk HTTP event collector ingress (it's behind the proxy on port 8088 but externally it's 443 with a LE cert)
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow egress traffic to anywhere and with any protocol
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}