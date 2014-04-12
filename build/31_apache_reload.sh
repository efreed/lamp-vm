 
say "Restart apache with fresh copy of default.vhost"
    cp /vagrant/default.vhost /etc/apache2/sites-available/default
    service apache2 reload >/dev/null 2>&1
