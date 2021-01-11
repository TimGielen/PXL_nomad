job "node-exporter" {
  datacenters = ["dc1"]
  type = "service"

  group "node-exporter" {
    count = 2
    network {
      port "node-exporter_ui" {
        to = 9100
         static = 9100
      }
    }
    task "node-exporter"{
        driver = "docker"
        config {
          image = "prom/node-exporter:latest"
          ports = ["node-exporter_ui"]
          logging {
            type = "journald"
            config {
              tag = "node-exporter"
            }
          }
        }
        service {
          name = "node-exporter"
        }
      }
   }
}