
say "Installing MySQL."
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -y mysql-server >/dev/null 2>&1
    sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
    restart mysql
    mysql -u root mysql <<< "GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;"
