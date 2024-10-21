provider "google" {
  credentials = file("/J4D_AC_Key.json")
  project     = "my-nx-438310"
  region      = "me-west1"
}


#provider "kubernetes" {
#  host                    = "https://${google_container_cluster.gke_cluster.endpoint}"
#  client_certificate      = base64decode(google_container_cluster.gke_cluster.master_auth[0].client_certificate)
#  client_key              = base64decode(google_container_cluster.gke_cluster.master_auth[0].client_key)
#  cluster_ca_certificate  = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
# }

provider "kubernetes" {
  config_path = "C:/Users/Joshua/.kube/config"  # Adjust this path if necessary
}