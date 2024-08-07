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
    host   = optional(string, null)
    port   = optional(number, )
  })
}

variable "postgress_config" {
  type = object({
    create = bool
    name   = optional(string, "superset-db")
    host   = optional(string, null)
    port   = optional(number, 5432)
    user   = optional(string, null)
    pass   = optional(string, null)
  })
}
