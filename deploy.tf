resource "helm_release" "service" {
  count = var.deploy_service ? 1 : 0

  name       = var.name
  namespace  = var.namespace
  repository = "https://dasmeta.github.io/helm/"
  chart      = "base"

  values = [
    yamlencode(var.helm_values)
  ]
}
