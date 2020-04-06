resource "aws_security_group" "sg_cloud-quickstart-cowrie" {
  name        = "sg_cloud-quickstart-cowrie"
  description = "Cloud Quickstart Security Group "

  ingress {
    # Allow honeypot SSH in from anywhere
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    # Allow (real) SSH in only from our current public IP
    from_port        = 31337
    to_port          = 31337
    protocol         = "tcp"
    cidr_blocks      = [var.MY_PUBLIC_IP]
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