provider "aws" {
  skip_requesting_account_id = true
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  endpoints {
    lambda          = "http://localhost:4566"
    apigateway      = "http://localhost:4566"
    iam             = "http://localhost:4566"
    s3              = "http://localhost:4566"
    cloudformation  = "http://localhost:4566"
    cognitoidp      = "http://localhost:4566"
    rds             = "http://localhost:4566"
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_namespace" "lanchonete" {
  metadata {
    name = "lanchonete-namespace"
  }
}

resource "kubernetes_deployment" "lanchonete" {
  metadata {
    name      = "lanchonete-deployment"
    namespace = kubernetes_namespace.lanchonete.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "example"
      }
    }

    template {
      metadata {
        labels = {
          app = "example"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "example"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}