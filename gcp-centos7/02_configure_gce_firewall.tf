resource "google_compute_network" "default" {
  name = "cloud-c7-net"
}

resource "google_compute_firewall" "fw-cloud-c7-ssh" {
  name    = "fw-cloud-c7-ssh"
  network = google_compute_network.default.name
  
  direction = "INGRESS"
  source_ranges = [var.MY_PUBLIC_IP]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw-cloud-c7-web" {
  name    = "fw-cloud-c7-web"
  network = google_compute_network.default.name
  
  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

// Block common malware spreading ports with egress rules
resource "google_compute_firewall" "fw-cloud-c7-egress-filter" {
  name    = "fw-cloud-c7-egress-filter"
  network = google_compute_network.default.name
  
  direction = "EGRESS"

  deny {
    protocol = "tcp"
    ports    = ["69", "135", "137-139", "161-162", "445", "514", "6660-6669"]
  }

  deny {
    protocol = "udp"
    ports    = ["69", "135", "137-139", "161-162", "445", "514", "6660-6669"]
  }
}