
# specify folder containing database backups
cd /vagrant

skippedAGz="no"

for f in *-init.sql.gz
do
  db=${f/-init.sql.gz/}
  if [ "$db" = "*" ]; then
    #do nothing
    skippedAGz="yes"
  elif [ -f "/var/restored_$db" ]; then
    say "Skipping uncompress of $db"
  else
    say "Uncompressing the database: $db"
	  gunzip "/vagrant/$f"
    say "Finished uncompressing DB"
  fi
done

for f in *-init.sql
do
  db=${f/-init.sql/}
  if [ "$db" = "*" ]; then
    if [ "$skippedAGz" = "no" ]; then
      echo "=================================================================="
      echo "To restore from a mysql database:"
      echo "  Name the sql dump file in this format:  databasename-init.sql"
      echo "  Or the gzipped sql file in this format:  databasename-init.sql.gz"
      echo "  and place in the same folder as Vagrantfile" 
      echo "=================================================================="
    fi
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
  fi
done

