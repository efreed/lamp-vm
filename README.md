

# Software Prerequisites
- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Install [Vagrant](http://www.vagrantup.com/downloads.html)
- Windows-only: An SSH client must be in your path in one of the following ways:
    - See if it's already available.  Open a command prompt, type ssh, press enter
    - Copy the files from the "Windows\SSH Client" directory into C:\HashiCorp\Vagrant\bin
    - Install Git and make sure "C:\Program Files (x86)\Git\bin" is in your path

# Configuration Highlights
- Define what services you want accessible from _localhost_ by editing the "forwarded_port" commands in Vagrantfile
- These contents are expected to be one folder deep from the root of the repository (such as /server).  If that's not the case, edit line 27 of Vagrantfile
- From within the VM, the path "/reporoot/" will read/write from/to the repository
- The root of the repo is the default website root.  Edit this on on line 7 of build/#build.sh
- You'll likely be customizing the default.vhost file for your project
- The root user for the mysql server has a blank password, this should be secured accordingly

# To configure what's installed
- In the /build folder, files starting with a # are commented out (will not be run)
- Comment/uncomment files to change what's included in the build
- Scripts that don't set success=TRUE will run again with the "vagrant provision" command

# To Start The VM
Before starting the VM the first time, place one or more mysql dump files in this folder.  Format the filename to be either _databasename-init.sql_ or _databasename-init.sql.gz_

In Windows, you can use the convenience commands in the Windows folder, just run the Start command
Documentation is at [VagrantUp.com](http://docs.vagrantup.com/v2/cli), become familiar with these common commands:
 [up](http://docs.vagrantup.com/v2/cli/up.html),
 [ssh](http://docs.vagrantup.com/v2/cli/ssh.html),
 [halt](http://docs.vagrantup.com/v2/cli/halt.html),
 [status](http://docs.vagrantup.com/v2/cli/status.html),
 [provision](http://docs.vagrantup.com/v2/cli/provision.html)
 

