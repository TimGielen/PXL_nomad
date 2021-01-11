job "alertmanager" {
  datacenters = ["dc1"]
  type = "service"

  group "alertmanager" {
    count = 2
    network {
      port "alertmanager_ui" {
        to = 9093
         static = 9093
      }
    }
    task "alertmanager" {
       template{
            change_mode = "noop"
            destination = "local/alertmanager.yml"
            data = <<EOH
---
global:
  resolve_timeout: 5m
  http_config: {}
  smtp_hello: localhost
  smtp_require_tls: true
  pagerduty_url: https://events.pagerduty.com/v2/enqueue
  opsgenie_api_url: https://api.opsgenie.com/
  wechat_api_url: https://qyapi.weixin.qq.com/cgi-bin/
  victorops_api_url: https://alert.victorops.com/integrations/generic/20131114/alert/
route:
  receiver: "pagerduty-notifications"
  group_by:
  - alertname
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 1h
inhibit_rules:
- source_match:
    severity: critical
  target_match:
    severity: warning
  equal:
  - alertname
  - dev
  - instance
receivers:
- name: 'pagerduty-notifications'
  pagerduty_configs:
  - service_key: eec3986bd085403daa7735059cf21dbd
    send_resolved: true
templates: []

EOH
}     
      driver = "docker"
      config {
        image = "prom/alertmanager:latest"
        volumes = [
            "local/alertmanager.yml:/etc/alertmanager/alertmanager.yml"
          ]
        ports = ["alertmanager_ui"]
      }
      resources {
        cpu    = 1000
        memory = 100
      }
      service {
        name = "alertmanager"
        tags = ["urlprefix-/alertmanager strip=/alertmanager"]
      }
    }
  }
}
