#!/bin/bash
#
# Update test installation from live backup
#
# Run as ubuntu user

PCKDIR="/data/phpeace/peacelink"
TESTDIR="/data/phpeace/peacetest"
TEMPDIR="/data/temp/testdb"
CURDIR="/data/pckui/test"

# sync images
sudo -u www-data rsync -apR --delete --info=progress2 $PCKDIR/uploads/ $TESTDIR/uploads/

# test logo
sudo cp $CURDIR/assets/peacetest.jpg $TESTDIR/uploads/custom/logo.jpg

# block search engines
sudo cp /data/phpeace/disallow.txt $TESTDIR/pub/robots.txt

# set perms
sudo chown -R www-data.www-data $TESTDIR

# extract db credentials
DBNAME=`php -r 'include_once("/data/phpeace/peacetest/custom/config.php");$c=new Config();echo $c->dbconf["database"];'`
DBUSER=`php -r 'include_once("/data/phpeace/peacetest/custom/config.php");$c=new Config();echo $c->dbconf["user"];'`
DBPASS=`php -r 'include_once("/data/phpeace/peacetest/custom/config.php");$c=new Config();echo $c->dbconf["password"];'`

mkdir -p $TEMPDIR

# restore db
cp /data/backup/database/db_peacelink*.sql.gz $TEMPDIR/peacelink.sql.gz
gunzip $TEMPDIR/peacelink.sql.gz
mysql -u $DBUSER -p$DBPASS $DBNAME < $TEMPDIR/peacelink.sql

# sanitise db
mysql -u $DBUSER -p$DBPASS $DBNAME < $CURDIR/scripts/pcktest.sql

# export to s3
mysqldump -u $DBUSER -p$DBPASS --add-drop-table --skip-lock-tables $DBNAME | gzip > $TEMPDIR/peacelink_san.sql.gz
aws s3 cp $TEMPDIR/peacelink_san.sql.gz s3://peacelink-backup/db/

# clean up
rm -r $TEMPDIR

# publish
