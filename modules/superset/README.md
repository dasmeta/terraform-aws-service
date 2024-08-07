# superset

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_superset"></a> [superset](#module\_superset) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarms"></a> [alarms](#input\_alarms) | Alarms are enabled by default. You need to set SNS topic name to send alarms. Use custom\_values to customize alarms. | <pre>object({<br>    enabled       = optional(bool, true)<br>    sns_topic     = string<br>    custom_values = optional(any, {})<br>    restarts = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    replicas = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    network_in = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    network_out = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    maximum_replicas_usage = optional(object({<br>      enabled          = optional(bool, true)<br>      maximum_replicas = optional(number)<br>      }), {<br>      enabled          = true<br>      maximum_replicas = 3 //The count of HPA maximum for a service. It will be used as a threshold for HPA maximum alarm.<br>    })<br><br>  })</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"superset"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create namespace | `bool` | `false` | no |
| <a name="input_ingress_config"></a> [ingress\_config](#input\_ingress\_config) | n/a | <pre>object({<br>    create        = bool<br>    hosts         = optional(list(string), [])<br>    path          = optional(string, "/*")<br>    pathType      = optional(string, "ImplementationSpecific")<br>    group_name    = optional(string, "default")<br>    success-codes = optional(string, "200-399")<br>    # listen-ports   = optional(string, "'[{\"HTTPS\":443}]'")<br>    class = optional(string, "alb")<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"superset"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"superset"` | no |
| <a name="input_postgress_config"></a> [postgress\_config](#input\_postgress\_config) | n/a | <pre>object({<br>    create = bool<br>    name   = optional(string, "superset")<br>    host   = optional(string, "superset-postgresql")<br>    port   = optional(number, 5432)<br>    user   = optional(string, "superset")<br>    pass   = optional(string, "superset")<br>  })</pre> | n/a | yes |
| <a name="input_redis_config"></a> [redis\_config](#input\_redis\_config) | n/a | <pre>object({<br>    create = bool<br>    host   = optional(string, "superset-redis-headless")<br>    port   = optional(number, 6379)<br>  })</pre> | n/a | yes |
| <a name="input_supeset_secret_key"></a> [supeset\_secret\_key](#input\_supeset\_secret\_key) | Generate your own superset secret key for encryption. Use 'openssl rand -base64 42' to generate a good key | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
