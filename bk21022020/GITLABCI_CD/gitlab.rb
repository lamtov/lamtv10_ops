external_url 'https://gitlab.ocs.com'
registry_external_url 'https://registry.ocs.com'
gitlab_rails['registry_api_url'] = "http://172.16.29.193:4000"
nginx['enable'] = true
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.key"
nginx['ssl_ciphers'] = "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256"
nginx['ssl_prefer_server_ciphers'] = "on"
nginx['ssl_protocols'] = "TLSv1.2 TLSv1.3"
registry_nginx['enable'] = true
registry_nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.crt"
registry_nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.key"
