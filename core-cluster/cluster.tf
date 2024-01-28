# Query xsmall instance size
data "civo_size" "xsmall" {
  filter {
    key    = "type"
    values = ["kubernetes"]
  }

  sort {
    key       = "ram"
    direction = "asc"
  }
}

# Create a firewall
resource "civo_firewall" "core-firewall" {
  name = "core"

  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = ["0.0.0.0/8"]
    action     = "allow"
  }
}

# Create a cluster without specific cluster type by default is k3s
resource "civo_kubernetes_cluster" "core-cluster" {
  name        = "core2"
  firewall_id = civo_firewall.core-firewall.id
  pools {
    label      = "front-end" // Optional
    size       = element(data.civo_size.xsmall.sizes, 0).name
    node_count = 3
  }
}