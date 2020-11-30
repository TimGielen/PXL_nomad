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
