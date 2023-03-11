resource "helm_release" "opentelemetry-demo" {
  name             = "opentelemetry-demo"
  chart            = "./charts/opentelemetry-demo"
  namespace        = "otel-demo"
  dependency_update = true
  create_namespace = true
}