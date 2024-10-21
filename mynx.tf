resource "kubernetes_deployment" "nx_deployment" {
  depends_on = [google_container_cluster.gke_cluster]
  metadata {
    name = "mynx-deployment"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "mynx"
      }
    }

    template {
      metadata {
        labels = {
          app = "mynx"
        }
      }

      spec {
        container {
          name  = "mynx"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
