# The GKE cluster endpoint is the public IP that you can use to connect to the cluster.
output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.gke_cluster.endpoint
}

# To interact with the Kubernetes cluster, a kubeconfig file is needed.
# This block outputs the required fields for it to be constructed.
output "gke_kubeconfig" {
  description = "Kubeconfig for accessing the GKE cluster"
  value = <<EOL
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate}
    server: https://${google_container_cluster.gke_cluster.endpoint}
  name: ${google_container_cluster.gke_cluster.name}
contexts:
- context:
    cluster: ${google_container_cluster.gke_cluster.name}
    user: ${google_container_cluster.gke_cluster.name}
  name: ${google_container_cluster.gke_cluster.name}
current-context: ${google_container_cluster.gke_cluster.name}
kind: Config
users:
- name: ${google_container_cluster.gke_cluster.name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: gke-gcloud-auth-plugin
EOL
}

# The following blocks output node pool details such as 
# the name, machine type, and the number of nodes.
output "gke_node_pool_name" {
  description = "The name of the GKE node pool"
  value       = google_container_node_pool.srvr_nodes.name
}

output "gke_node_pool_machine_type" {
  description = "The machine type of the GKE node pool"
  value       = google_container_node_pool.srvr_nodes.node_config.0.machine_type
}

output "gke_node_pool_node_count" {
  description = "The current number of nodes in the node pool"
  value       = google_container_node_pool.srvr_nodes.initial_node_count
}

