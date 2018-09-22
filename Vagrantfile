# -*- mode: ruby -*-
# vi: set ft=ruby :

# configures atomic hosts (masters, nodes, load balancers) for openshift
openshift_constainer_host_script = <<-SHELL
  sudo su
  cp -r /home/vagrant/sync/ssh /root/.ssh
  cp /home/vagrant/sync/private/id_rsa.pub /root/.ssh/id_rsa.pub
  cp /home/vagrant/sync/private/id_rsa /root/.ssh/id_rsa
  chown -R root.root /root/.ssh
  chmod 644 /root/.ssh/id_rsa.pub
  chmod 600 /root/.ssh/id_rsa
  systemctl restart sshd
  #
  # configure storage on atomic - https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/managing_containers/managing_storage_with_docker_formatted_containers
  systemctl stop docker docker-storage-setup
  # reset the current container storage and remove the directory
  container-storage-setup --reset
  rm -rf /var/lib/docker/     
  # extend the root logical volume
  lvextend -r -L +2GB /dev/atomicos/root
  # create a new partition, physical volume and volume group
  parted /dev/sdb mktable gpt
  parted /dev/sdb mkpart primary 0% 100%
  pvcreate /dev/sdb1 -f
  vgcreate dockerlv /dev/sdb1
  # set the docker-storage-setup file that configures storage for the atomic host
  cp /home/vagrant/sync/docker-storage-setup /etc/sysconfig/docker-storage-setup
  cp /home/vagrant/sync/docker /etc/sysconfig/docker
  systemctl start docker docker-storage-setup
  cp /home/vagrant/sync/dns/resolv.conf /etc/resolv.conf
  SHELL

# sets up bind on a DNS host
dns_host_script = <<-SHELL
  apt-get update
  apt-get install -y bind9 bind9utils bind9-doc git
  cp /vagrant/dns/bind9 /etc/default/bind9
  cp /vagrant/dns/named.conf.options /etc/bind/named.conf.options
  cp /vagrant/dns/named.conf.local /etc/bind/named.conf.local
  mkdir /etc/bind/zones
  cp /vagrant/dns/db.tkeech.io /etc/bind/zones/db.tkeech.io
  cp /vagrant/dns/db.6.168.192 /etc/bind/zones/db.6.168.192
  service bind9 restart
  cp /vagrant/dns/head /etc/resolvconf/resolv.conf.d/head 
  resolvconf -u
  git clone https://github.com/openshift/openshift-ansible  
  cd openshift-ansible && git checkout release-3.10
  SHELL

container_host_box = "centos/atomic-host"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.define "dns" do |dns|
    dns.vm.box = "ubuntu/trusty64"
    dns.vm.hostname = 'ns1'
    dns.vm.network "private_network", ip: "192.168.6.241", bridge:"wlp0s20f3"

    dns.vm.provider :virtualbox do |vb|
      vb.name="ns1" 
      vb.memory = "1024"
      vb.cpus = 1
    end

    dns.vm.provision "shell", inline: dns_host_script
  end

  config.vm.define "master1" do |master1|
    master1.vm.box = container_host_box
    master1.vm.hostname = 'master1'
    master1.vm.network "private_network", ip: "192.168.6.201", bridge:"wlp0s20f3"
    master1.vm.provider "virtualbox" do |vb|
        vb.name="master1" 
        vb.memory = "1024"
        vb.cpus = 1
        
        master1disk = '/home/tk/projects/master1disk.vdi'
        vb.customize ['createhd', '--filename', master1disk, '--variant', 'Fixed', '--size', 5 * 1024]
        vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
        vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', master1disk]
      end  
    master1.vm.provision "shell", inline: openshift_constainer_host_script
  end 

=begin 
  config.vm.define "master2" do |master2|
    master2.vm.box = container_host_box
    master2.vm.hostname = 'master2'
    master2.vm.network "private_network", ip: "192.168.6.202", bridge:"wlp0s20f3"
    master2.vm.provider "virtualbox" do |vb|
        vb.name="master2" 
        vb.memory = "1024"
        vb.cpus = 1
        
        master2disk = '/home/tk/projects/master2disk.vdi'
        vb.customize ['createhd', '--filename', master2disk, '--variant', 'Fixed', '--size', 5 * 1024]
        vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
        vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', master2disk]
      end  
      master2.vm.provision "shell", inline: openshift_constainer_host_script
  end  

  config.vm.define "master3" do |master3|
    master3.vm.box = container_host_box
    master3.vm.hostname = 'master3'
    master3.vm.network "private_network", ip: "192.168.6.203", bridge:"wlp0s20f3"
    master3.vm.provider "virtualbox" do |vb|
        vb.name="master3" 
        vb.memory = "1024"
        vb.cpus = 1
        
        master3disk = '/home/tk/projects/master3disk.vdi'
        vb.customize ['createhd', '--filename', master3disk, '--variant', 'Fixed', '--size', 5 * 1024]
        vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
        vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', master3disk]
      end  
      master3.vm.provision "shell", inline: openshift_constainer_host_script
  end 

  config.vm.define "node1" do |node1|
    node1.vm.box = container_host_box
    node1.vm.hostname = 'node1'
    node1.vm.network "private_network", ip: "192.168.6.211", bridge:"wlp0s20f3"
    node1.vm.provider "virtualbox" do |vb|
        vb.name="node1" 
        vb.memory = "1024"
        vb.cpus = 1
        
        node1disk = '/home/tk/projects/node1disk.vdi'
        vb.customize ['createhd', '--filename', node1disk, '--variant', 'Fixed', '--size', 2 * 1024]
        vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
        vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', node1disk]
      end  
      node1.vm.provision "shell", inline: openshift_constainer_host_script
  end  
  
  config.vm.define "node2" do |node2|
    node2.vm.box = container_host_box
    node2.vm.hostname = 'node2'
    node2.vm.network "private_network", ip: "192.168.6.212", bridge:"wlp0s20f3"
    node2.vm.provider "virtualbox" do |vb|
        vb.name="node2" 
        vb.memory = "1024"
        vb.cpus = 1
        
        node2disk = '/home/tk/projects/node2disk.vdi'
        vb.customize ['createhd', '--filename', node2disk, '--variant', 'Fixed', '--size', 2 * 1024]
        vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
        vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', node2disk]
      end  
      node2.vm.provision "shell", inline: openshift_constainer_host_script
  end    

  config.vm.define "lb1" do |lb1|
    lb1.vm.box = container_host_box
    lb1.vm.hostname = 'lb1'
    lb1.vm.network "private_network", ip: "192.168.6.221", bridge:"wlp0s20f3"
    lb1.vm.provider "virtualbox" do |vb|
        vb.name="lb1" 
        vb.memory = "1024"
        vb.cpus = 1
        
        lb1disk = '/home/tk/projects/lb1disk.vdi'
        vb.customize ['createhd', '--filename', lb1disk, '--variant', 'Fixed', '--size', 2 * 1024]
        vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
        vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lb1disk]
      end  
      lb1.vm.provision "shell", inline: openshift_constainer_host_script
  end   
=end  

end
