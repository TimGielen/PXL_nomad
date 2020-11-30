data_dir = "{{ client_data_dir }}"

name = "{{ansible_hostname}}"

client {
  enabled = true
  servers = ["{{ server_address }}:4647"]
}

bind_addr = "{{ ip_address }}"