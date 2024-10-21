resource "google_compute_network" "vpc_network" {
  name                    = "mynx-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "mynx-subnet"
  network       = google_compute_network.vpc_network.id
  region        = "me-west1"
  ip_cidr_range = "10.0.1.0/24" //This is within standard private IP ranges, and allows for
                                //only 255 hosts since its for a demo project.
}