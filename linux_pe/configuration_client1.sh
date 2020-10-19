#!/bin/bash

mkdir /tmp/client1
sudo mv /tmp/client1.hcl /root/client1.hcl
sudo nohup nomad agent -config /root/client1.hcl &
sleep 20
echo -ne '\n'
sudo echo "bind_addr = \"192.168.1.4\"" >> /etc/consul.d/consul.hcl
sudo echo "retry_join = [\"192.168.1.3\"]" >> /etc/consul.d/consul.hcl
sudo systemctl start consul