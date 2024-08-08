variable "name" {
  type    = string
  default = "superset"
}

variable "namespace" {
  type    = string
  default = "superset"
}

variable "create_namespace" {
  type        = bool
  description = "Create namespace"
  default     = false
}

variable "cluster_name" {
  type    = string
  default = "superset"
}

variable "supeset_secret_key" {
  type        = string
  description = "Generate your own superset secret key for encryption. Use 'openssl rand -base64 42' to generate a good key"
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

variable "redis_config" {
  type = object({
    create = bool
    host   = optional(string, "superset-redis-headless")
    port   = optional(number, 6379)
  })
}

variable "postgress_config" {
  type = object({
    create = bool
    name   = optional(string, "superset")
    host   = optional(string, "superset-postgresql")
    port   = optional(number, 5432)
    user   = optional(string, "superset")
    pass   = optional(string, "superset")
  })
}

variable "ingress_config" {
  type = object({
    create          = bool
    hosts           = optional(list(string), [])
    path            = optional(string, "/*")
    pathType        = optional(string, "ImplementationSpecific")
    group_name      = optional(string, "default")
    success-codes   = optional(string, "200-399")
    class           = optional(string, "alb")
    certificate_arn = optional(string, "")
  })
}
