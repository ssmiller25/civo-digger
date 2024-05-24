
resource "helm_release" "nginx_ingress" {
  name       = "digger-backend"

  repository = "https://diggerhq.github.io/helm-charts/"
  chart      = "digger-backend"


  # Values

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name = "digger.service.type"
    value = "ClusterIP"
  }

  set {
    name = "digger.ingress.enabled"
    value = "true"
  }

  set {
    name = "digger.annotations"
    value = "kubernetes.io/ingress.class: traefik"
  }

  set {
    name = "digger.ingress.host"
    value = "digger.${data.civo_kubernetes_cluster.core-cluster.dns_entry}"
  }

  set {
    name = "digger.secret.BEARER_AUTH_TOKEN"
    value = #TODO: Random string
  }

  set {
    name = "digger.secret.HTTP_BASIC_AUTH
    value = "1"
  }

  set {
    name = "digger.secret.HTTP_BASIC_AUTH_USERNAME
    value = "diggercivo"
  }


  set {
    name = "digger.secret.HTTP_BASIC_AUTH_PW
    value = #TODO: Another random string
  }

  set {
    name = "digger.postgres.host"
    value = civo_database.digger-database.dns_endpoint
  }

  set {
    name = "digger.postgres.database"
    value = "diggerdb"
  }

  set {
    name = "digger.postgres.username"
    value = civo_database.digger-database.username
  }

  set {
    name = "digger.postgres.password"
    value = civo_database.digger-database.password
  }

  # GITHUB_ORG: GITHUBORG
  #HOSTNAME: digger.${CLUSTERDNS}
  #BEARER_AUTH_TOKEN: ${RANDOM_AUTH_TOKEN}
  #DATABASE_URL: ${DBURL}
  # Example: DATABASE_URL: "postgres://postgres:root@postgres:5432/postgres?sslmode: disable"
  #HTTP_BASIC_AUTH: 1
  #HTTP_BASIC_AUTH_USERNAME: diggercivo
  #HTTP_BASIC_AUTH_PASSWORD: ${HTTP_BASIC_AUTH_PW}
  #ALLOW_DIRTY: false # set to true if the database has already a schema configured
}