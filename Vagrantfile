# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here.
  # For a complete reference, see docs.vagrantup.com/v2

  # The box is a OS snapshot to start with
  # It's easiest to use one listed at vagrantcloud.com/discover/featured
  # hashicorp is the maker of Vagrant, the 32 bit version sets up easier
  config.vm.box = "hashicorp/precise32"

  # Map localhost ports to hit the VM
  # Ex: "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  # Instead of mapping ports, create a virtual IP with all ports available
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Share a additional folders to the guest VM.
  # The first argument is a relative path from this Vagrantfile
  # The second argument is the path in the VM to mount the folder.
  config.vm.synced_folder "../", "/reporoot"

  # config.vm.provider "virtualbox" do |vb|
  #   # VirtualBox-specific configs go here
  #   # To change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end

  # Shell-based provisioning
  config.vm.provision "shell", path: "runonce.sh"
 
  # Scripts to run as sudo on every "vagrant provision"
  config.vm.provision "shell", path: "mysql_init.sh"
  config.vm.provision "shell", path: "refresh_vhost.sh"
 
  # Scripts to run not as sudo on every "vagrant provision"
  #config.vm.provision "shell", path: 'file.sh', privileged: false

end
