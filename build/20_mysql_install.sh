
say "Installing MySQL."
    yum install -y mysql-server >/dev/null 2>&1
    #edit /etc/my.cnf to allow network access
    #how ?sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
    service mysqld restart
    mysql -u root mysql <<< "GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;"
    # set to run on startup
    chkconfig mysqld on

# Don't run this build script again
success=TRUE