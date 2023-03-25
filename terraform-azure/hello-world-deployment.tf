resource "kubernetes_deployment" "hello-world" {
  metadata {
    name = "hello-world"
  }
  spec {
    selector {
      match_labels = {
        app = "hello-world"
      }
    }
    replicas = 1
    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }
      spec {
        container {
          name  = "hello-world"
          image = "hello-world:latest"
          ports {
            container_port = 8080
          }
        }
      }
    }
  }
}
