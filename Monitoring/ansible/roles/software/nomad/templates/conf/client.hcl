data_dir = "{{ client_data_dir }}"

name = "{{ansible_hostname}}"

client {
  enabled = true
  servers = ["{{ server_address }}:4647"]
  network_interface = "eth1"
}

bind_addr = "{{ ip_address }}"
telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
