#!/bin/bash

mkdir /tmp/server
sudo mv /tmp/server.hcl /root/server.hcl
sudo mv /tmp/webserver.nomad /root/webserver.nomad
sudo nohup nomad agent -config /root/server.hcl &
sleep 20
echo -ne '\n'
sudo nomad job run /root/webserver.nomad
echo -ne '\n'
sudo echo "server = true" >> /etc/consul.d/consul.hcl
sudo echo "bootstrap_expect=1" >> /etc/consul.d/consul.hcl
sudo echo "bind_addr = \"192.168.1.3\"" >> /etc/consul.d/consul.hcl
sudo systemctl start consul