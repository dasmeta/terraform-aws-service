resource "helm_release" "service" {
  count = var.deploy_service ? 1 : 0

  name             = var.name
  namespace        = var.namespace
  repository       = var.repository
  chart            = var.chart
  create_namespace = var.create_namespace
  version          = var.chart_version

  values = [
    yamlencode(var.helm_values)
  ]
}
