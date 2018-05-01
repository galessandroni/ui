#!/bin/bash
#
# Update test installation from live backup
#
# Run as ubuntu user

PCKDIR="/data/phpeace/peacelink"
TESTDIR="/data/phpeace/peacetest"

# sync images
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'custom' $PCKDIR/uploads/ $TESTDIR/uploads/
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'css' --exclude 'robots.txt' $PCKDIR/pub/ $TESTDIR/pub/

# block search engines
sudo cp /data/phpeace/disallow.txt $TESTDIR/pub/robots.txt

# set perms
sudo chown -R www-data.www-data $TESTDIR
