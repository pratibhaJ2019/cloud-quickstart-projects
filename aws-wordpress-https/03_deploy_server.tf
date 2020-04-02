variable "instance_username" {
  type    = string
  default = "ubuntu"
}

data "aws_ami" "lookup_latest_ubuntu_lts" {
  most_recent = true

  filter {
    name = "name"
    # Ubuntu Server LTS
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance_cloud-quickstart-wp" {
  ami           = data.aws_ami.lookup_latest_ubuntu_lts.id
  instance_type = "t2.micro"
  # Assign the SSH key we defined earlier to this instance
  key_name = "key_cloud-quickstart-wp"
  tags = {
    Name = "cloud-quickstart-wordpress"
  }
  security_groups = ["sg_cloud-quickstart-wp"]

  # Use remote-exec to run a pointless command on the remote server because remote-exec will wait for the
  # server instance to deploy properly, whereas local-exec wouldn't. If we just try to run our Ansible
  # playbook immediately then Vultr probably won't have finished deploying the server before it tries to run.
  provisioner "remote-exec" {
    inline = ["echo Hello_World"]

    connection {
      host        = aws_instance.instance_cloud-quickstart-wp.public_ip
      type        = "ssh"
      user        = var.instance_username
      private_key = file(var.AWS_PRIVKEY)
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.instance_username}' --private-key '${var.AWS_PUBKEY}' -i '${aws_instance.instance_cloud-quickstart-wp.public_ip},' helloworld.yml"
  }
}