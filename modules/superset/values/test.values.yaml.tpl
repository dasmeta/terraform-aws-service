postgresql:
  enabled: ${postgresql_enabled}
redis:
  enabled: ${redis_enabled}
extraSecretEnv:
  SUPERSET_SECRET_KEY: ${superset_key}
supersetNode:
  connections:
    db_host: ${db_host}
    db_name: ${db_name}
    db_pass: ${db_pass}
    db_port: ${db_port}
    db_user: ${db_user}
    redis_host: ${redis_host}
    redis_port: ${redis_port}
