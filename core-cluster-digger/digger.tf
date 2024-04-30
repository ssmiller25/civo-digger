data "kustomization_overlay" "digger_overlay" {
  resources = [
    "manifests/core"
  ]

  patches {
    patch_json6902 = <<-EOT
      - op: add
        path: /spec/template/spec/containers/0/env
        value: [
          {
            "name": "MY_ENV_VAR",
            "value": "${var.my_env_var}"
          }
        ]
    EOT
  }
}

resource "kustomization_resource" "my_kustomization" {
  for_each = data.kustomization_overlay.my_overlay.ids

  manifest = data.kustomization_overlay.my_overlay.manifests[each.value]
}
