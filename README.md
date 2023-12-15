# service

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
| <a name="input_alarms"></a> [alarms](#input\_alarms) | Alarms enabled by default you need set sns topic name for send alarms for customize alarms threshold use custom\_values | <pre>object({<br>    enabled       = optional(bool, true)<br>    sns_topic     = string<br>    custom_values = optional(any, {})<br>  })</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_helm_values"></a> [helm\_values](#input\_helm\_values) | Values which is overwrite chart defaults | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Service names | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
