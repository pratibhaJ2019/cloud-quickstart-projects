variable "instance_username" {
  type    = string
  default = "ubuntu"
}

resource "google_compute_instance" "default" {
  name         = "wordpress-cloud-quickstart"
  # f1-micro is the only instance type falling within GCP Free Tier
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  // Launch a shielded VM (https://cloud.google.com/shielded-vm)
  // We need to make sure our boot image supports this (https://cloud.google.com/compute/docs/images#shielded-images)
  shielded_instance_config {
    enable_secure_boot = true
    enable_vtpm = true
    enable_integrity_monitoring = true
  }

  network_interface {
    // Join the instance to our network we named in the previous step, which will bring our firewall rules too.
    // We want to be careful to avoid joining the "default" network as for some reason GCP creates default-allow ingress rules for SSH and even RDP(!).
    network = google_compute_network.default.name
    access_config {
      // This will use an ephemeral IP
    }
  }

  // Add our SSH keys to the instance
  metadata = {
    ssh-keys = "${var.instance_username}:${file(var.GCP_PUBKEY)}"
  }

  # Use remote-exec to run a pointless command on the remote server because remote-exec will wait for the
  # server instance to deploy properly, whereas local-exec wouldn't. If we just try to run our Ansible
  # playbook immediately then Vultr probably won't have finished deploying the server before it tries to run.
  provisioner "remote-exec" {
    inline = ["echo Hello_World"]

    connection {
      # This is pretty ugly compared to AWS's 'self.public_ip', but this is what the official Terraform provider page recommends.
      host        = self.network_interface.0.access_config.0.nat_ip
      type        = "ssh"
      user        = var.instance_username
      private_key = file(var.GCP_PRIVKEY)
    }
  }

  # Set up the host with a shared playbook
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.instance_username}' --private-key '${var.GCP_PRIVKEY}' -i '${self.network_interface.0.access_config.0.nat_ip},' ../_shared_playbooks/ubuntu-docker/playbook.yml"
  }

  # Set up NGINX reverse proxy
  provisioner "local-exec" {
    command = "sleep 20 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.instance_username}' --private-key '${var.AWS_PRIVKEY}' -i '${self.public_ip},' ../_shared_playbooks/nginx-proxy/playbook.yml"
  }

  # Set up Wordpress
  provisioner "local-exec" {
    command = "sleep 20 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.instance_username}' --private-key '${var.AWS_PRIVKEY}' -i '${self.public_ip},' ../_shared_playbooks/wordpress/playbook.yml"
  }
}
