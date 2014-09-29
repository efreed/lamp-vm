
# specify folder containing database backups
cd /vagrant

echo ""
echo "=================================================================="
echo "To restore from a mysql database:"
echo "  Name the sql dump file in this format:  databasename-init.sql"
echo "  Or the gzipped sql file in this format:  databasename-init.sql.gz"
echo "  and place in the same folder as Vagrantfile" 
echo "=================================================================="

for f in *-init.sql.gz
do
  db=${f/-init.sql.gz/}
  if [ "$db" = "*" ]; then
    #do nothing
    dummy="yes"
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
    # * is thrown into file search results sometimes, don't look for a db named *
    dummy="yes"
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

