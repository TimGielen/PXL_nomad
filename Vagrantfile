# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  

  config.vm.define "nomadserver" do |nomadserver|
    nomadserver.vm.box = "centos/7"
    nomadserver.vm.hostname = "nomadserver"
    nomadserver.vm.provision "shell", path: "linux_pe/installation.sh"
	nomadserver.vm.provision "file", source: "linux_pe/server.hcl", destination: "/tmp/server.hcl"
	nomadserver.vm.provision "file", source: "linux_pe/webserver.nomad", destination: "/tmp/webserver.nomad"
	nomadserver.vm.provision "shell", path: "linux_pe/configuration_server.sh"  
	nomadserver.vm.network "private_network", ip: "192.168.1.3",
    virtualbox__intnet: "mynetwork"
	nomadserver.vm.network "forwarded_port", guest: 8500, host: 8500
  end

  config.vm.define "nomadclient1" do |nomadclient1|
    nomadclient1.vm.box = "centos/7"
    nomadclient1.vm.hostname = "nomadclient1"
    nomadclient1.vm.provision "shell", path: "linux_pe/installation.sh"	
	nomadclient1.vm.provision "file", source: "linux_pe/client1.hcl", destination: "/tmp/client1.hcl"
	nomadclient1.vm.provision "shell", path: "linux_pe/configuration_client1.sh"
	nomadclient1.vm.network "private_network", ip: "192.168.1.4",
    virtualbox__intnet: "mynetwork"
  end
  
  config.vm.define "nomadclient2" do |nomadclient2|
    nomadclient2.vm.box = "centos/7"
    nomadclient2.vm.hostname = "nomadclient2"
    nomadclient2.vm.provision "shell", path: "linux_pe/installation.sh"	
	nomadclient2.vm.provision "file", source: "linux_pe/client2.hcl", destination: "/tmp/client2.hcl"
	nomadclient2.vm.provision "shell", path: "linux_pe/configuration_client2.sh"
	nomadclient2.vm.network "private_network", ip: "192.168.1.5",
    virtualbox__intnet: "mynetwork"
  end
end