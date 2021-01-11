data_dir = "{{ server_data_dir }}"

name = "{{ansible_hostname}}"

server {
  enabled = true
  bootstrap_expect = 1
}

advertise {
 rpc  = "{{ ip_address }}"
 serf = "{{ ip_address }}"
 http = "{{ ip_address }}"
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
