module "this" {
  source = "../../"

  deploy_service = false

  name         = "api01"
  namespace    = "test"
  cluster_name = "eks-dev"

  alarms = {
    sns_topic = "default"
  }
}
