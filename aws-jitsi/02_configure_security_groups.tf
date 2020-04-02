resource "aws_security_group" "sg_cloud-quickstart-jitsi" {
  name        = "sg_cloud-quickstart-jitsi"
  description = "Cloud Quickstart Security Group "

  ingress {
    # Allow SSH in only from our current public IP
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.MY_PUBLIC_IP]
  }

  ingress {
    # Allow HTTP in from anywhere
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    # Allow HTTPS in from anywhere
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