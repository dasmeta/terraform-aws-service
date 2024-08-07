module "test" {
  source = "../../"

  name               = "superset"
  namespace          = "superset"
  cluster_name       = "buycycle-cluster"
  supeset_secret_key = "sdgiadgiagdiagdi"

  postgress_config = {
    create = true
  }
  redis_config = {
    create = true
  }
  alarms = {
    enabled   = false
    sns_topic = ""
  }
}
