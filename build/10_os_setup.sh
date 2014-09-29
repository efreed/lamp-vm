 
# Note: ending a command with ">/dev/null 2>&1" means "hide output except for error messages"
# http://stackoverflow.com/questions/16995425/how-does-cmd-dev-null-21-work
 
say "Set Time Zone."
    cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
    #cp /usr/share/zoneinfo/America/Boise /etc/localtime
    #cp /usr/share/zoneinfo/America/Chicago /etc/localtime
    #cp /usr/share/zoneinfo/America/New_York /etc/localtime
 
say "Updating the package manager"
    # Update library
    yum update >/dev/null 2>&1
 
say "Installing handy packages"
    yum install -y vim curl git-core ftp zip unzip locate >/dev/null 2>&1


# Don't run this build script again
success=TRUE