#!/usr/bin/env bash
  
# Determine if this machine has already been provisioned
# Basically, run everything after this command once, and only once
if [ -f "/var/vagrant_runonce" ]; then 
    exit 0
fi
 
function say {
    printf "\n--------------------------------------------------------\n"
    printf "\t$1"
    printf "\n--------------------------------------------------------\n"
}
# Note: ending a command with ">/dev/null 2>&1" means "hide output except for error messages"
# http://stackoverflow.com/questions/16995425/how-does-cmd-dev-null-21-work
 
say "Installing Apache and setting it up."
    # Update aptitude library
    apt-get update >/dev/null 2>&1
    # Install apache2 
    apt-get install -y apache2 >/dev/null 2>&1
    # Remove /var/www path
    rm -rf /var/www
    # Symbolic link to webroot folder in the repository
    ln -fs /reporoot/path-to-website /var/www
    # Enable mod_rewrite
    a2enmod rewrite
 
say "Installing MySQL."
    export DEBIAN_FRONTEND=noninteractive
    # (already run above) apt-get update >/dev/null 2>&1
    apt-get install -y mysql-server >/dev/null 2>&1
    sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
    restart mysql
    mysql -u root mysql <<< "GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;"
 
say "Installing handy packages"
    apt-get install -y curl git-core ftp zip unzip imagemagick vim colordiff >/dev/null 2>&1
 
say "Installing PHP Modules"
    # Install php5, libapache2-mod-php5, php5-mysql curl php5-curl
    apt-get install -y php5 php5-cli php5-common php5-dev php5-imagick php5-imap php5-gd libapache2-mod-php5 php5-mysql php5-curl >/dev/null 2>&1
 
say "Runonce completed successfully"
    touch /var/vagrant_runonce