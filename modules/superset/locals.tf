locals {
  redis_config = {
    "postgresql" : {
      "enabled" : var.postgress_config.create,
    },
    "redis" : {
      "enabled" : var.redis_config.create,
    },
    "supersetNode" : {
      "connections" : {
        "db_host" : "${var.name}-postgresql"
        "db_port" : "5432"
        "db_user" : "superset"
        "db_pass" : "superset"
        "db_name" : "superset"
        "redis_host" : var.redis_config.host
        "redis_port" : var.redis_config.port
      }
    }
  }

  postgress_config = {
    "postgresql" : {
      "enabled" : var.postgress_config.create,
    },
    "redis" : {
      "enabled" : var.redis_config.create,
    },
    "supersetNode" : {
      "connections" : {
        "db_host" : var.postgress_config.host
        "db_port" : var.postgress_config.port
        "db_user" : var.postgress_config.user
        "db_pass" : var.postgress_config.pass
        "db_name" : var.postgress_config.name
        "redis_host" : "${var.name}-redis-headless"
        "redis_port" : "6379"
      }
    }
  }

  redis_postgress_config = {
    "postgresql" : {
      "enabled" : var.postgress_config.create,
    },
    "redis" : {
      "enabled" : var.redis_config.create,
    },
    "supersetNode" : {
      "connections" : {
        "db_host" : var.postgress_config.host
        "db_port" : var.postgress_config.port
        "db_user" : var.postgress_config.user
        "db_pass" : var.postgress_config.pass
        "db_name" : var.postgress_config.name
        "redis_host" : var.redis_config.host
        "redis_port" : var.redis_config.port
      }
    }
  }

  default_config = {
    "postgresql" : {
      "enabled" : "true",
    },
    "redis" : {
      "enabled" : "true",
    },
    "supersetNode" : {
      "connections" : {
        "db_host" : "${var.name}-postgresql"
        "db_port" : "5432"
        "db_user" : "superset"
        "db_pass" : "superset"
        "db_name" : "superset"
        "redis_host" : "${var.name}-redis-headless"
        "redis_port" : "6379"
      }
    }
  }

  helm_values = var.redis_config.create ? (var.postgress_config.create ? local.default_config : local.postgress_config) : (var.postgress_config.create ? local.redis_config : local.redis_postgress_config)
}
