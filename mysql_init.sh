#!/usr/bin/env bash

function say {
    printf "\n--------------------------------------------------------\n"
    printf "\t$1"
    printf "\n--------------------------------------------------------\n"
}

# specify starting folder
cd /vagrant

for f in *-bak.sql.gz
do
  db=${f/-bak.sql.gz/}
  if [ "$db" = "*" ]; then
    #do nothing
    printf ""
  elif [ -f "/var/restored_$db" ]; then
    say "Skipping uncompress of $db"
  else
    say "Uncompressing the database: $db"
	  gunzip "/vagrant/$f"
    say "Finished uncompressing DB"
  fi
done

for f in *-bak.sql
do
  db=${f/-bak.sql/}
  if [ "$db" = "*" ]; then
    echo "=================================================================="
    echo "To restore from a mysql database:"
    echo "  Name the sql dump file in this format:  databasename-bak.sql"
    echo "  Or the gzipped sql file in this format:  databasename-bak.sql.gz"
    echo "  and place in the same folder as Vagrantfile" 
    echo "=================================================================="
  elif [ -f "/var/restored_$db" ]; then
    say "Skipping db restore of $db"
  else
    say "Creating the database: $db"
      mysql -u root -e "CREATE DATABASE IF NOT EXISTS $db"
    say "Populating $db"
      mysql -u root -D $db < "/vagrant/$f"
    say "Finished Populating $db, compressing DB"
      touch "/var/restored_$db"
	  gzip "/vagrant/$f"
    say "Finished compressing DB"
  fi
done
