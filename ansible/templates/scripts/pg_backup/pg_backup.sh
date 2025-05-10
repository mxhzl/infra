#! /bin/bash

# adapted from
# https://serverfault.com/questions/59838/whats-the-best-way-to-automate-backing-up-of-postgresql-databases

# pg_dumpall errors because it doesn't have access to template1. fix or give up
DUMPALL="/usr/bin/pg_dumpall --globals-only -U $DB_USERNAME -h $DB_HOST -p $DB_PORT"
PGDUMP="/usr/bin/pg_dump -U $DB_USERNAME -h $DB_HOST -p $DB_PORT"
PSQL="/usr/bin/psql -U $DB_USERNAME -h $DB_HOST -p $DB_PORT -d $DB_DB --set=sslmode=require"

# directory to save backups in, must be rwx by postgres user
BASE_DIR='/mnt/mxhzl/backups/postgres'
YMD=$(date "+%Y-%m-%d")
DIR="$BASE_DIR/$YMD"
mkdir -p "$DIR"
cd "$DIR"

# get list of databases in system, exclude the tempate dbs and do internal db
DBS=( $($PSQL --list --tuples-only |
          awk '!/template[01]/ && !/_dodb/ && $1 != "|" {print $1}') )

# first dump entire postgres database, including pg_shadow etc.
$DUMPALL | gzip -9 > "$DIR/db.out.gz"

/usr/local/bin/b2 file upload mxhzl-pg-backups "$DIR/db.out.gz" "$YMD/db.out.gz"

# now loop through each individual database and backup the
# schema and data separately
for database in "${DBS[@]}" ; do
    SCHEMA="$DIR/$database.gz"

    # export data from postgres databases to plain text:

    # dump schema
    $PGDUMP --create --clean "$database" | gzip -9 > "$SCHEMA"

    # upload files to b2
    /usr/local/bin/b2 file upload mxhzl-pg-backups "$SCHEMA" "$YMD/$database.gz"
done

# delete backup files older than 30 days
echo deleting old backup files:
find "$BASE_DIR/" -mindepth 1 -type d -mtime +30 -print0 |
    xargs -0r rm -rfv
