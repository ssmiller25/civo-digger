data "civo_size" "small" {
  filter {
    key      = "name"
    values   = ["db.small"]
    match_by = "re"
  }
  filter {
    key    = "type"
    values = ["database"]
  }
}

data "civo_database_version" "db" {
  filter {
    key    = "engine"
    values = ["postgresql"]
  }
}

data "civo_kubernetes_cluster" "core-cluster" {
    name = "core-cluster"
}

resource "civo_database" "digger-database" {
  name    = "digger-db"
  size    = element(data.civo_size.small.sizes, 0).name
  nodes   = 1
  engine  = element(data.civo_database_version.db.versions, 0).engine
  version = element(data.civo_database_version.db.versions, 0).version
}



resource "null_resource" "install_digger" {
    provisioner "local-exec" {
        command = "scripts/bootstrap-digger.sh"
        environment = {
            KUBECONFIGDATA=data.civo_kubernetes_cluster.core-cluster.kubeconfig
            DBURL="postgres://${civo_database.digger-database.username}:${civo_database.digger-database.password}@${civo_database.digger-database.dns_endpoint}:${civo_database.digger-database.port}/digger-db"
            CLUSTERDNS=data.civo_kubernetes_cluster.core-cluster.dns_entry
            # Replace with real email addresss
            EMAILADDR="test@test.com"
            # Replace with real org
            GITHUBORG=testrealorg
        }
    }
}