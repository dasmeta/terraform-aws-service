locals {
  helm_values = {
    "postgresql" : {
      "enabled" : var.postgress_config.create
    },
    "redis" : {
      "enabled" : var.redis_config.create
    },
    "extraSecretEnv" : {
      "SUPERSET_SECRET_KEY" : var.supeset_secret_key
    }
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
    "ingress" : {
      "enabled" : var.ingress_config.create
      "hosts" : var.ingress_config.hosts
      "path" : var.ingress_config.path
      "pathType" : var.ingress_config.pathType
      "annotations" : {
        "alb.ingress.kubernetes.io/group.name" : var.ingress_config.group_name
        "alb.ingress.kubernetes.io/success-codes" : var.ingress_config.success-codes
        # "alb.ingress.kubernetes.io/listen-ports": var.ingress_config.listen-ports
        "kubernetes.io/ingress.class" : var.ingress_config.class
      }
    }
  }
}
