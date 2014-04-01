
function say {
    printf "\n--------------------------------------------------------\n"
    printf " $1"
    printf "\n--------------------------------------------------------\n"
}

say "Copy default.vhost to /etc/apache2/sites-available/default and restart"
    cp /vagrant/default.vhost /etc/apache2/sites-available/default
    service apache2 reload

say "Apache restarted"
