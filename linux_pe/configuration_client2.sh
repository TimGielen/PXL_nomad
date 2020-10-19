#!/bin/bash

mkdir /tmp/client2
sudo mv /tmp/client2.hcl /root/client2.hcl
sudo nohup nomad agent -config /root/client2.hcl &
sleep 20
echo -ne '\n'
sudo echo "bind_addr = \"192.168.1.5\"" >> /etc/consul.d/consul.hcl
sudo echo "retry_join = [\"192.168.1.3\"]" >> /etc/consul.d/consul.hcl
sudo systemctl start consul