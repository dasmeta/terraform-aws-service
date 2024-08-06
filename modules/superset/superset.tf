module "superset" {
  source = "../../"

  name          = var.name
  namespace     = var.namespace
  repository    = "http://apache.github.io/superset/"
  chart         = "superset/superset"
  chart_version = "0.12.11"
  cluster_name  = var.cluster_name
  helm_values   = local.helm_values
  alarms        = var.alarms
}
