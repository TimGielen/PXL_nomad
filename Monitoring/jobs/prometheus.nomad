job "prometheus" {
  datacenters = ["dc1"]
  type = "service"

  group "prometheus" {
    count = 1
    network {
      port "prometheus_ui" {
        to = 9090
         static = 9090
      }
    }
    task "prometheus" {
      template {
        change_mode = "noop"
        destination = "local/webserver_alert.yml"
        data = <<EOH
---
groups:
- name: prometheus_alerts
  rules:
  - alert: Webserver down
    expr: absent(up{job="webserver"})
    for: 10s
    labels:
      severity: critical
    annotations:
      description: "Our webserver is down."
EOH
      }

      template {
        change_mode = "noop"
        destination = "local/prometheus.yml"
        data = <<EOH
---
global:
  scrape_interval:     15s
  evaluation_interval: 15s

alerting:
  alertmanagers:
  - consul_sd_configs:
    - server: '{{ env "NOMAD_IP_prometheus_ui" }}:8500'
      services: ['alertmanager']

rule_files:
  - "webserver_alert.yml"

scrape_configs:

  - job_name: alertmanager
    static_configs:
      - targets: ['192.168.1.4:9093', '192.168.1.5:9093']

  - job_name: 'nomad_metrics'

    consul_sd_configs:
    - server: '{{ env "NOMAD_IP_prometheus_ui" }}:8500'
      services: ['nomad-client', 'nomad']

    relabel_configs:
    - source_labels: ['__meta_consul_tags']
      regex: '(.*)http(.*)'
      action: keep

    scrape_interval: 5s
    metrics_path: /v1/metrics
    params:
      format: ['prometheus']

  - job_name: 'webserver'

    consul_sd_configs:
    - server: '{{ env "NOMAD_IP_prometheus_ui" }}:8500'
      services: ['mongoDB']

    metrics_path: /metrics
  - job_name: node
    static_configs:
      - targets: ['192.168.1.4:9100','192.168.1.5:9100']
  - job_name: mongoDB-exporter
    static_configs:
      - targets: ['192.168.1.4:9216', '192.168.1.5:9216']
EOH
      }
      driver = "docker"
      config {
        image = "prom/prometheus:latest"
        volumes = [
          "local/webserver_alert.yml:/etc/prometheus/webserver_alert.yml",
          "local/prometheus.yml:/etc/prometheus/prometheus.yml"
        ]
        ports = ["prometheus_ui"]
      }
      resources {
        network {
          mbits = 10
        }
      }
      service {
        name = "prometheus"
        tags = ["urlprefix-/"]
        port = "prometheus_ui"
        check {
          name     = "prometheus_ui port alive"
          type     = "http"
          path     = "/-/healthy"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
