
say "Installing Apache and setting it up."
    # Install apache2 
    apt-get install -y apache2 >/dev/null 2>&1
    # Remove /var/www path
    rm -rf /var/www
    # Symbolic link to webroot folder in the repository
    ln -fs "/reporoot$pathToWebroot" /var/www
    # Enable mod_rewrite
    a2enmod rewrite >/dev/null 2>&1
    # Remove log folder
    rm -rf /var/log/apache2
    # Symbolic link to logs folder in the host system
    ln -fs /vagrant/apachelogs /var/log/apache2
 
say "Installing PHP Modules"
    # Install php5, libapache2-mod-php5, php5-mysql curl php5-curl
    apt-get install -y php5 php5-cli php5-common php5-dev php5-imagick php5-imap php5-gd libapache2-mod-php5 php5-mysql php5-curl >/dev/null 2>&1
 
# Don't run this build script again
success=TRUE