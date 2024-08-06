module "test" {
  source = "../../"

  name         = "superset"
  namespace    = "superset"
  cluster_name = "buycycle-cluster"

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
