#!/bin/bash
# This simple script should be run on a DB machine and it will create a DB dump

DB_DUMP_DIRECTORY="db_dump_dir_dummy"
DATE=$(date +"%d-%b-%Y")

# Database credentials
user="dummy_db_username"
password="dummy_db_password"
host="dummy_dump_host"
db_name="dummy_db_name"


# Dump database into SQL file
mysqldump --user=$user --password=$password --host=$host $db_name > $DB_DUMP_DIRECTORY/$db_name-$DATE.sql

# Delete files older than 7 days
find $DB_DUMP_DIRECTORY/* -mtime +7 -exec rm {} \;
