module "this" {
  source = "../../"

  helm_values = {
    "image" : {
      "repository" : "repository: xxxxx.dkr.ecr.us-east-1.amazonaws.com/api",
      "tag" : "latest"
    },
    "config" : {
      "NODE_ENV" : "dev"
      "PORT" : "8080"
      "MONGODB_URI" : "mongodb+srv://username:password@db?retryWrites=true&w=majority"
    },
    "podAnnotations" : {
      "linkerd.io/inject" : "enabled"
    },
    "replicaCount" : 2,
  }
  name         = "api01"
  namespace    = "test"
  cluster_name = "eks-dev"

  alarms = {
    sns_topic = "Default"
    custom_values = {
      network_in = {
        period    = 300,
        statistic = "avg",
        threshold = 80000
        equation  = "gte"
      },
      network_out = {
        period    = 300,
        statistic = "avg",
        threshold = 80000
        equation  = "gte"
      },
      restarts = {
        period    = 300,
        statistic = "max",
        threshold = 3
        equation  = "gte"
      },
      replicas = {
        period    = 300,
        statistic = "avg",
        threshold = 0
        equation  = "lte"
      },
      maximum_replicas_usage = {
        period    = 300,
        statistic = "avg",
        threshold = 6
        equation  = "gte"
      },
    }
  }
}
