job "mongoDB" {
  datacenters = ["dc1"]
  type = "service"

  group "mongoDB" {
    count = 1
    network {
      port "mongoDB_port" {
        to = 27017
         static = 27017
      }
    }
    task "mongoDB" {
      driver = "docker"
      config {
        image = "mongo:latest" 
        ports = ["mongoDB_port"]
      }
      resources {
        cpu    = 1000
        memory = 300
      }
      service {
        name = "mongo"
      }
    }
  }
}