locals {
  release_name = "opentelemetry-demo"
}

resource "helm_release" "opentelemetry_demo" {
  name             = local.release_name
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-demo"
  version          = "0.19.8"
  create_namespace = true
  namespace        = "otel_demo"
  max_history      = 3

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}