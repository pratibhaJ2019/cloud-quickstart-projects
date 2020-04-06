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

resource "aws_instance" "instance_cloud-quickstart-cowrie" {
  ami           = data.aws_ami.lookup_latest_ubuntu_lts.id
  instance_type = "t2.micro"
  # Assign the SSH key we defined earlier to this instance
  key_name = "key_cloud-quickstart-cowrie"
  tags = {
    Name = "cowrie-cloud-quickstart"
  }
  security_groups = ["sg_cloud-quickstart-cowrie"]

  # Use remote-exec to change the SSH port before we make Cowrie listen on :22 with the Ansible playbook below
  provisioner "remote-exec" {
    inline = [
      "echo 'Port 31337' | sudo tee --append /etc/ssh/sshd_config",
      "sudo systemctl restart ssh"
    ]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = var.instance_username
      private_key = file(var.AWS_PRIVKEY)
    }
  }

  # Set up the host with a shared playbook
  provisioner "local-exec" {
    command = "sleep 20 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.instance_username}' --private-key '${var.AWS_PRIVKEY}' -i '${self.public_ip},' -e 'ansible_port=31337' ../_shared_playbooks/ubuntu-docker/playbook.yml"
  }

  # Set up with the specific playbook for this host
  provisioner "local-exec" {
    command = "sleep 60 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.instance_username}' --private-key '${var.AWS_PRIVKEY}' -i '${self.public_ip},' -e 'ansible_port=31337' ../_shared_playbooks/cowrie/playbook.yml"
  }
}