# Update: 20240128
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

data "civo_size" "small" {
  filter {
    key    = "type"
    values = ["kubernetes"]
  }

    filter {
        key = "name"
        values = ["g4s.kube.small"]
        match_by = "re"
    }
}

# Create a firewall
resource "civo_firewall" "core-firewall" {
  name                 = "core"
  create_default_rules = false
  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }
  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "80"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }
  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "443"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }
}

# Create a cluster without specific cluster type by default is k3s
resource "civo_kubernetes_cluster" "core-cluster" {
  name         = "core"
  firewall_id  = civo_firewall.core-firewall.id
  applications = "cert-manager"
  pools {
    size       = element(data.civo_size.small.sizes, 0).name
    node_count = 3
  }
}