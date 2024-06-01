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


resource "civo_database" "digger-database" {
  name    = "digger-db"
  size    = element(data.civo_size.small.sizes, 0).name
  nodes   = 1
  engine  = element(data.civo_database_version.db.versions, 0).engine
  version = element(data.civo_database_version.db.versions, 0).version
}

