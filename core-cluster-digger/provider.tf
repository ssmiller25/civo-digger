
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

# Borrowed from https://github.com/civo/terraform-template/blob/main/provider.tf#L34C1-L50C2
provider "helm" {
  kubernetes {
    host                   = data.civo_kubernetes_cluster.core-cluster.api_endpoint
    client_certificate     = base64decode(yamldecode(data.civo_kubernetes_cluster.core-cluster.kubeconfig).users[0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(data.civo_kubernetes_cluster.core-cluster.kubeconfig).users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(yamldecode(data.civo_kubernetes_cluster.core-cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)
  }
}

provider "kubernetes" {
  host                   = data.civo_kubernetes_cluster.core-cluster.api_endpoint
  client_certificate     = base64decode(yamldecode(data.civo_kubernetes_cluster.core-cluster.kubeconfig).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(data.civo_kubernetes_cluster.core-cluster.kubeconfig).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(data.civo_kubernetes_cluster.core-cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)

}