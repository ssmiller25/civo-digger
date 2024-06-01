# Kubernetes clusterissuers in pure terraform
resource "kubernetes_manifest" "clusterissuer_letsencrypt_prod" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind" = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-prd"
    }
    "spec" = {
      "acme" = {
        "email" = "${var.letsencryptemail}"
        "privateKeySecretRef" = {
          "name" = "letsencrypt-prd"
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "traefik"
              }
            }
          },
        ]
      }
    }
  }
}

