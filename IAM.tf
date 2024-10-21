# Referencing the service account 
data "google_service_account" "gke_service_account" {
  project = "my-nx-438310"
  account_id = "j4d-537"
}

# resource "google_project_iam_binding" "gke_sa_binding" {
#  role = "roles/kubernetes.engineAdmin"  # Uses Kubernetes Engine Admin role
#  project = "my-nx-438310"
#  members = [
#    "serviceAccount:${data.google_service_account.gke_service_account.email}"
#  ]
#}

resource "google_project_iam_binding" "gke_sa_viewer_binding" {
  role    = "roles/viewer"
  project = "my-nx-438310"
  members = [
    "serviceAccount:${data.google_service_account.gke_service_account.email}"
  ]
}

resource "google_project_iam_binding" "gke_sa_network_admin_binding" {
  role    = "roles/compute.networkAdmin"
  project = "my-nx-438310"
  members = [
    "serviceAccount:${data.google_service_account.gke_service_account.email}"
  ]
}

resource "google_project_iam_binding" "gke_sa_resource_admin_binding" {
  role    = "roles/resourcemanager.projectIamAdmin"
  project = "my-nx-438310"
  members = [
    "serviceAccount:${data.google_service_account.gke_service_account.email}"
  ]
}