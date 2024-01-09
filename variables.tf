variable "name" {
  type        = string
  description = "Service name. It's used as a helm release name and specified PodName in AWS CloudWatch metrics for which alarms will be created."
}

variable "namespace" {
  type        = string
  description = "Namespace"
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "helm_values" {
  type        = any
  description = "Values which overwrite chart defaults"
  default     = null
}

variable "alarms" {
  type = object({
    enabled       = optional(bool, true)
    sns_topic     = string
    custom_values = optional(any, {})
    restarts = optional(object({
      enabled = bool
      }), {
      enabled = true
    })
    replicas = optional(object({
      enabled = bool
      }), {
      enabled = true
    })
    network_in = optional(object({
      enabled = bool
      }), {
      enabled = true
    })
    network_out = optional(object({
      enabled = bool
      }), {
      enabled = true
    })
    maximum_replicas_usage = optional(object({
      enabled          = optional(bool, true)
      maximum_replicas = optional(number)
      }), {
      enabled          = true
      maximum_replicas = 3 //The count of HPA maximum for a service. It will be used as a threshold for HPA maximum alarm.
    })

  })
  description = "Alarms are enabled by default. You need to set SNS topic name to send alarms. Use custom_values to customize alarms."
}


variable "deploy_service" {
  type        = bool
  description = "Wether to deploy the service via helm or not."
  default     = true
}
