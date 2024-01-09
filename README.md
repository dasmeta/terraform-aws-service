# service

## What

This module
- deploys services by using `helm_release` tf resource:
  - it is conditional: set `deploy_service` to false if you don't want to deploy a service,
- creates these basic alarms in CloudWatch for the service:
  - service pod's received traffic is out of anomaly band,
  - service pod's transmitted traffic is out of anomaly band,
  - service pod has 2 or more restarts in 5 minues,
  - service has 0 available replicas,
  - service HPA has been on its maximum for 5 minutes: there are maximum pods of the service.

## How
Alarms are configured by default but can be customized via `alarms.custom_values` parameter.
By default all 5 alarms are enabled but each of them can be disabled:
```
module "this" {
  ....

  alarms = {
    sns_topic = "default"
    restarts = {
      enabled = false
    }
    network_out = {
      enabled = false
    }
  }

  ....
}
```
In this case restarts, network_out alarms will not be created. Only maximum_replicas_usage, replicas, network_in alarms will be created.

## Use Cases
Please check `examples` folder for more detailed examples.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cw_alerts"></a> [cw\_alerts](#module\_cw\_alerts) | dasmeta/monitoring/aws//modules/alerts | 1.3.5 |

## Resources

| Name | Type |
|------|------|
| [helm_release.service](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarms"></a> [alarms](#input\_alarms) | Alarms are enabled by default. You need to set SNS topic name to send alarms. Use custom\_values to customize alarms. | <pre>object({<br>    enabled       = optional(bool, true)<br>    sns_topic     = string<br>    custom_values = optional(any, {})<br>    restarts = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    replicas = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    network_in = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    network_out = optional(object({<br>      enabled = bool<br>      }), {<br>      enabled = true<br>    })<br>    maximum_replicas_usage = optional(object({<br>      enabled          = bool<br>      maximum_replicas = number<br>      }), {<br>      enabled          = true<br>      maximum_replicas = 3 //The count of HPA maximum for a service. It will be used as a threshold for HPA maximum alarm.<br>    })<br><br>  })</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_deploy_service"></a> [deploy\_service](#input\_deploy\_service) | Wether to deploy the service via helm or not. | `bool` | `true` | no |
| <a name="input_helm_values"></a> [helm\_values](#input\_helm\_values) | Values which overwrite chart defaults | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Service name. It's used as a helm release name and specified PodName in AWS CloudWatch metrics for which alarms will be created. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace | `string` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
