resource "kubernetes_service" "nx_service" {
  depends_on = [google_container_cluster.gke_cluster]
  metadata {
    name = "mynx-service"
  }

  spec {
    selector = {
      app = "mynx"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 80
    }
  }
}
