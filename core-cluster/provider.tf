
# Specify required provider as maintained by civo
terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}

# Configure the Civo Provider
# Assumes CIVO_TOKEN set in the pipeline
provider "civo" {
  region = "LON1"
}
