
say "Installing Apache and setting it up."
    # Install apache2 (run yum groupinfo "Web Server" for what packages are included)
    yum groupinstall -y "Web Server" >/dev/null 2>&1
    # Remove /var/www/html path
    rm -rf /var/www/html
    # Symbolic link to webroot folder in the repository
    ln -fs "/reporoot$pathToWebroot" /var/www/html
    # Remove log folder
    rm -rf /etc/httpd/logs
    # Symbolic link to logs folder in the host system
    ln -fs /vagrant/apachelogs /etc/httpd/logs
    # set to run on startup
    chkconfig httpd on
    service httpd start
 
say "Installing PHP Modules"
    # for 5.3.3:  yum groupinstall -y "PHP Support" >/dev/null 2>&1
    # for 5.4.29:
    rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm >/dev/null 2>&1
    yum install -y php54w php54w-gd php54w-pear php54w-xml php54w-mysqlnd php54w-mbstring php54w-soap php54w-mcrypt
    # configure pacific time
    sed -i -e 's/;date.timezone =/date.timezone = America\/Los_Angeles/' /etc/php.ini
    sed -i -e 's/short_open_tag=Off/short_open_tag=On/' /etc/php.ini
    service httpd restart
 
# Don't run this build script again
success=TRUE
