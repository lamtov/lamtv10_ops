concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "des"
  url = "https://gitlab.ocs.com/"
  token = "z8E1mFDV6xY7zUr3zpiM"
  executor = "shell"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]

[[runners]]
  name = "des2"
  url = "https://gitlab.ocs.com/"
  token = "roHyqExGZ3nEPh-7tUYw"
  executor = "shell"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]

[[runners]]
  name = "docker_test"
  url = "https://gitlab.ocs.com/"
  token = "uzFb1VvxuyYaGt3WgZ82"
  executor = "docker"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
  [runners.docker]
    tls_verify = false
    image = "python_27"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/cache"]
    extra_hosts = ["gitlab.ocs.com:172.16.29.193", "registry.ocs.com:172.16.29.193"]
    pull_policy = "if-not-present"
    shm_size = 0

[[runners]]
  name = "ssh"
  url = "https://gitlab.ocs.com/"
  token = "696UWhav6psnj3kVAKU1"
  executor = "ssh"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
  [runners.ssh]
    user = "root"
    password = "123456@Epc"
    host = "172.16.29.193"
    port = "22"

[[runners]]
  name = "des"
  url = "https://gitlab.ocs.com/"
  token = "YDicHbYsPirQvVhLx4BS"
  executor = "ssh"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
  [runners.ssh]
    user = "root"
    password = "123456@Epc"
    host = "172.16.29.194"
    port = "22"

[[runners]]
  name = "runner_for_lamtv10"
  url = "https://gitlab.ocs.com/"
  token = "MGT7ZzfFGWyyqhiyktsL"
  executor = "shell"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
