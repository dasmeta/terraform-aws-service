locals {
  helm_values = templatefile(
    "${path.module}/values/test.values.yaml.tpl",
    {
      postgresql_enabled = var.postgress_config.create
      redis_enabled      = var.redis_config.create
      superset_key       = var.supeset_secret_key
      db_host            = var.postgress_config.host
      db_port            = var.postgress_config.port
      db_user            = var.postgress_config.user
      db_pass            = var.postgress_config.pass
      db_name            = var.postgress_config.name
      redis_host         = var.redis_config.host
      redis_port         = var.redis_config.port
    }
  )
}
