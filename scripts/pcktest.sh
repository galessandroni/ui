#!/bin/bash
#
# Update test installation from live backup
#
# Run as ubuntu user


CURRENTDIR=`dirname $0`
source $CURRENTDIR/config.sh

# sync images
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'custom' $PCKDIR/uploads/ $TESTDIR/uploads/
sudo -u www-data rsync -rtup --links --delete --info=progress2 --exclude 'css' --exclude 'robots.txt' $PCKDIR/pub/ $TESTDIR/pub/

# block search engines
sudo cp /data/phpeace/disallow.txt $TESTDIR/pub/robots.txt

# set perms
sudo chown -R www-data.www-data $TESTDIR

# sanitise db
pcksan.sh

# update script
mkdir -p $TESTDIR/scripts/custom
cp $CURRENTDIR/pcktest.php $TESTDIR/scripts/custom
cd $TESTDIR
pwd
php $TESTDIR/scripts/custom/pcktest.php

# slack