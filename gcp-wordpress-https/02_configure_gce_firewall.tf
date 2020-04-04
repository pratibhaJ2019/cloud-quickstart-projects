resource "google_compute_network" "default" {
  name = "cloud-wp-net"
}

resource "google_compute_firewall" "fw-cloud-wp-ssh" {
  name    = "fw-cloud-wp-ssh"
  network = google_compute_network.default.name
  
  direction = "INGRESS"
  source_ranges = [var.MY_PUBLIC_IP]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw-cloud-wp-web" {
  name    = "fw-cloud-wp-web"
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