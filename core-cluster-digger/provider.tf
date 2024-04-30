
# Specify required provider as maintained by civo
terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}

# Configure the Civo Provider
# Make sure CIVO_TOKEN set in the pipeline
provider "civo" {
  region = "LON1"
}

resource "local_file" "k8sauth" {
  content  = data.civo_kubernetes_cluster.core-cluster.kubeconfig
  filename = "${path.module}/civo.kubeconfig"
}

provider "kubernetes" {
  config_path    = local_file.k8sauth.filename
}