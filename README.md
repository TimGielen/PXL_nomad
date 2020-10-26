Aanpak van de pe:
Hicham: screen casten tijdens het uitwerken van de PE.
Tim: Meekijken => extra controle


scripts creeren:

		- 1 algemeen script voor het installeren van docker, consul en nomad

		- voor elke node apart een configuratie script (provision hcl voor elke client naar de tmp directorie, script erna uitgevooerd door root)												- client1.hcl: we geven hier de naam, de data dir mee, of het een client is, een ip adress met de juiste poort (voor de consul), een pport die zorgt dat er geen collision kan gebeuren met server1 en dangeling afzetten met de dockers om er voor te voorkomen dat ze elkaar proberen te stoppen
		
               - client2.hcl: iedem als client1.hcl maar client1 wordt client2
		
               - server.hcl : we geven hier de naam, de data dir mee, of het een server is, rpc geven we een ip mee.
		
               - configuration_client1.sh: creeën van een dir in tmp die client1 noemt, verplaatesn van de hcl file van tmp naar root, gebruik van het nohup commando (dit zorgt er voor dat het commando in de achtergrond blijft runnen en er op deze manier geen nieuwe shell moet worden opgestart https://www.computerhope.com/unix/unohup.htm) van uit het configuratie van de /root/client1.hcl en daarna wordt er op enter geduwd van in de console
		
               - configuration_client2.sh: idem als configuration_client1 maar alles in met client1 wordt client2
		
               - configuration_server.sh:creeën van een dir in tmp die client1 noemt, verplaatesn van de hcl file van tmp naar root, gebruik van het nohup commando (dit zorgt er voor dat het commando in de achtergrond blijft runnen en er op deze manier geen nieuwe shell moet worden opgestart) van uit het configuratie van de /root/client1.hcl daarna wordt er op enter geduwd van in de console, als laatste wordt de nomad job gerunned en weer op enter geduwd.
		
               - installation.sh: inloggen als root, installeren yum en curl, yum config manager de repo van hashicorp toevoegen, intalleren consul en nomad, yum config manager de repo van docker voor centos toevoegen, installeren van de docker-ce/docker-ce-cli/ containerd.io, het starten en enable van docker
		
               - werbserver.nomad: we maken hier een job aan in nomad, we geven mee dat dit een service is, dat deze 2 keer wordt uitgevoerd, dat dit een docker is, configuration port mapping, logging journald met als tag WEBSERVER, service een webserver is en op de poort van de webserver_port zit, reources netwerk poort webserver_port.



# Nomad consul

The aim of this project is to provide a development environment based on [consul](https://www.consul.io) and [nomad](https://www.nomadproject.io) to manage container based microservices.

The following steps should make that clear;

bring up the environment by using [vagrant](https://www.vagrantup.com) which will create centos 7 virtualbox machine or lxc container.

The proved working vagrant providers used on an [ArchLinux](https://www.archlinux.org/) system are
* [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)
* [vagrant-libvirt](https://github.com/vagrant-libvirt/)
* [virtualbox](https://www.virtualbox.org/)

```bash
    $ vagrant up --provider lxc
    OR
    $ vagrant up --provider libvirt
    OR
    $ vagrant up --provider virtualbox
```

Once it is finished, you should be able to connect to the vagrant environment through SSH and interact with Nomad:

```bash
    $ vagrant ssh
    [vagrant@nomad ~]$
```
