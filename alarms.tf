module "cw_alerts" {
  count = var.alarms.enabled ? 1 : 0

  source  = "dasmeta/monitoring/aws//modules/alerts"
  version = "1.3.5"

  sns_topic = var.alarms.sns_topic

  alerts = concat(
    // Restarts
    var.alarms.restarts.enabled ? [
      {
        name   = "Service: High Restart Rate for ${var.name} (2 in 5 minutes) in Cluster ${var.cluster_name}"
        source = "ContainerInsights/pod_number_of_container_restarts"
        filters = {
          ClusterName = var.cluster_name,
          Namespace   = var.namespace
          PodName     = var.name,
        }
        period    = try(var.alarms.custom_values.restarts.period, 300),
        statistic = try(var.alarms.custom_values.restarts.statistic, "max"),
        threshold = try(var.alarms.custom_values.restarts.threshold, 2)
        equation  = try(var.alarms.custom_values.restarts.equation, "gte")
      },
    ] : [],
    // Replicas
    var.alarms.replicas.enabled ? [
      {
        name   = "Service: 0 available replicas for ${var.name} in Cluster ${var.cluster_name}"
        source = "ContainerInsights/service_number_of_running_pods"
        filters = {
          ClusterName = var.cluster_name,
          Namespace   = var.namespace
          Service     = var.name,
        }
        period    = try(var.alarms.custom_values.replicas.period, 300),
        statistic = try(var.alarms.custom_values.replicas.statistic, "avg"),
        threshold = try(var.alarms.custom_values.replicas.threshold, 0),
        equation  = try(var.alarms.custom_values.replicas.equation, "lte")
      },
    ] : [],
    // Network In
    var.alarms.network_in.enabled ? [
      {
        name   = "Service: Network In Traffic Anomaly for ${var.name} in Cluster ${var.cluster_name}",
        source = "ContainerInsights/pod_network_rx_bytes",
        filters = {
          ClusterName = var.cluster_name,
          Namespace   = var.namespace
          PodName     = var.name,
        },
        period            = try(var.alarms.custom_values.network_in.period, 300),
        statistic         = try(var.alarms.custom_values.network_in.statistic, "avg"),
        equation          = try(var.alarms.custom_values.network_in.equation, "ltlgtu")
        anomaly_detection = true
      },
    ] : [],
    // Network Out
    var.alarms.network_out.enabled ? [
      {
        name   = "Service: Network Out Traffic Anomaly for ${var.name} in Cluster ${var.cluster_name}",
        source = "ContainerInsights/pod_network_tx_bytes",
        filters = {
          ClusterName = var.cluster_name,
          Namespace   = var.namespace
          PodName     = var.name,
        },
        period            = try(var.alarms.custom_values.network_out.period, 300),
        statistic         = try(var.alarms.custom_values.network_out.statistic, "avg"),
        equation          = try(var.alarms.custom_values.network_out.equation, "ltlgtu")
        anomaly_detection = true
      },
    ] : [],
    // HPA Maximum
    var.alarms.maximum_replicas_usage.enabled ? [
      {
        name   = "Service: ${var.name} HPA has been on Maximum Replicas for 5 minutes in Cluster ${var.cluster_name}",
        source = "ContainerInsights/kube_deployment_status_replicas_available",
        filters = {
          ClusterName = var.cluster_name,
          Namespace   = var.namespace
          Deployment  = var.name,
        },
        period    = try(var.alarms.custom_values.maximum_replicas_usage.period, 300),
        statistic = try(var.alarms.custom_values.maximum_replicas_usage.statistic, "avg"),
        threshold = try(var.alarms.custom_values.maximum_replicas_usage.threshold, var.alarms.maximum_replicas_usage.maximum_replicas)
        equation  = try(var.alarms.custom_values.maximum_replicas_usage.equation, "gte")
      }
    ] : [],
  )

  depends_on = [
    helm_release.service
  ]
}
