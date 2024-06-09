
data "civo_kubernetes_cluster" "core-cluster" {
  name = "core-digger"
}

resource "helm_release" "digger-backend" {
  name = "digger-backend"

  repository = "https://diggerhq.github.io/helm-charts/"
  chart      = "digger-backend"


  # Values

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "digger.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "digger.ingress.enabled"
    value = "true"
  }

  set {
    name  = "digger.annotations"
    value = "kubernetes.io/ingress.class: traefik"
  }

  set {
    name  = "digger.ingress.host"
    value = "digger.${data.civo_kubernetes_cluster.core-cluster.dns_entry}"
  }

  set {
    name  = "digger.secret.BEARER_AUTH_TOKEN"
    value = random_string.bearer_auth_token.result
  }

  set {
    name  = "digger.secret.HTTP_BASIC_AUTH"
    value = "1"
  }

  set {
    name  = "digger.secret.HTTP_BASIC_AUTH_USERNAME"
    value = "diggercivo"
  }


  set {
    name  = "digger.secret.HTTP_BASIC_AUTH_PW"
    value = random_string.http_basic_auth_pw.result
  }

  set {
    name  = "digger.postgres.host"
    value = civo_database.digger-database.dns_endpoint
  }

  set {
    name  = "digger.postgres.database"
    # Hack to add sslmode to initial DB connection
    value = "postgres?sslmode=require"
  }

  set {
    name  = "digger.postgres.user"
    value = civo_database.digger-database.username
  }

  set {
    name  = "digger.secret.postgresPassword"
    value = civo_database.digger-database.password
  }
}