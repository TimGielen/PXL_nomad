job "mongodb-exporter" {
  datacenters = ["dc1"]
  type = "service"
  group "mongodb-exporter" {
    count = 2
    network {
      port "mongodb-exporter_ui" {
        to = 9216
         static = 9216
      }
    }
    task "mongodb-exporter"{
        driver = "docker"
        config {
          image = "ssalaues/mongodb-exporter:latest"
          ports = ["mongodb-exporter_ui"]
          logging {
            type = "journald"
            config {
              tag = "mongo-exporter"
            }
          }
        }
        service {
          name = "mongodb-exporter"
        }
      }
   }
}